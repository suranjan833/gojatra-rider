import 'dart:async';
import 'dart:convert';
import 'dart:io';

/// Go Jatra Captain — Model Context Protocol (MCP) Dart Server
///
/// Implements Anthropic's MCP (Model Context Protocol) JSON-RPC 2.0 specification.
/// Supports both:
///  1) Stdio mode (default): Reads JSON-RPC from stdin, writes to stdout.
///  2) HTTP mode (--port=8080): Serves JSON-RPC over HTTP.
void main(List<String> args) async {
  int? port;
  for (final arg in args) {
    if (arg.startsWith('--port=')) {
      port = int.tryParse(arg.split('=')[1]);
    }
  }

  final server = GoJatraMcpServer();
  if (port != null) {
    await server.startHttpServer(port);
  } else {
    server.startStdioServer();
  }
}

class GoJatraMcpServer {
  static const String serverName = 'go-jatra-captain-mcp';
  static const String serverVersion = '1.0.0';
  static const String protocolVersion = '2024-11-05';

  bool isOnline = true;
  double earningsToday = 1420.50;
  int completedTripsToday = 8;
  double captainRating = 4.92;
  Map<String, dynamic>? activeRide = {
    'ride_id': 'GJ-84920',
    'passenger_name': 'mera passenger',
    'passenger_phone': '+91 98301 22849',
    'pickup_address': 'Salt Lake Sector V, Webel More',
    'dropoff_address': 'Park Street Metro Station',
    'fare': 245.50,
    'status': 'incoming',
    'otp': '5824',
  };

  void startStdioServer() {
    stderr.writeln('[$serverName] STDIO mode active (MCP JSON-RPC 2.0)...');
    stdin.transform(utf8.decoder).transform(const LineSplitter()).listen((
      line,
    ) async {
      if (line.trim().isEmpty) return;
      try {
        final request = jsonDecode(line) as Map<String, dynamic>;
        final response = await handleJsonRpc(request);
        if (response != null) {
          stdout.writeln(jsonEncode(response));
        }
      } catch (e) {
        stdout.writeln(jsonEncode(_err(null, -32700, 'Parse error: $e')));
      }
    });
  }

  Future<void> startHttpServer(int port) async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    stderr.writeln(
      '[$serverName] HTTP MCP server listening on http://localhost:$port',
    );

    await for (final req in server) {
      req.response.headers.add('Access-Control-Allow-Origin', '*');
      req.response.headers.add(
        'Access-Control-Allow-Methods',
        'GET, POST, OPTIONS',
      );
      req.response.headers.add('Access-Control-Allow-Headers', 'Content-Type');

      if (req.method == 'OPTIONS') {
        req.response.statusCode = HttpStatus.ok;
        await req.response.close();
        continue;
      }
      if ((req.uri.path == '/' || req.uri.path == '/health') &&
          req.method == 'GET') {
        req.response
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'status': 'healthy',
              'server': serverName,
              'version': serverVersion,
              'duty_status': isOnline ? 'ONLINE' : 'OFFLINE',
            }),
          );
        await req.response.close();
        continue;
      }
      if (req.method == 'POST') {
        try {
          final body = await utf8.decoder.bind(req).join();
          final json = jsonDecode(body) as Map<String, dynamic>;
          final response = await handleJsonRpc(json);
          req.response
            ..headers.contentType = ContentType.json
            ..write(jsonEncode(response ?? {'jsonrpc': '2.0', 'result': {}}));
        } catch (e) {
          req.response
            ..statusCode = HttpStatus.badRequest
            ..headers.contentType = ContentType.json
            ..write(jsonEncode(_err(null, -32700, e.toString())));
        }
      } else {
        req.response.statusCode = HttpStatus.methodNotAllowed;
      }
      await req.response.close();
    }
  }

  Future<Map<String, dynamic>?> handleJsonRpc(Map<String, dynamic> req) async {
    final id = req['id'];
    final method = req['method'] as String?;
    final params = req['params'] as Map<String, dynamic>? ?? {};

    if (method == null) return _err(id, -32600, 'Missing method');
    if (method.startsWith('notifications/')) return null;

    switch (method) {
      case 'initialize':
        return {
          'jsonrpc': '2.0',
          'id': id,
          'result': {
            'protocolVersion': protocolVersion,
            'capabilities': {
              'tools': {'listChanged': false},
              'resources': {'subscribe': false},
              'prompts': {'listChanged': false},
            },
            'serverInfo': {'name': serverName, 'version': serverVersion},
          },
        };

      case 'ping':
        return {'jsonrpc': '2.0', 'id': id, 'result': {}};

      case 'tools/list':
        return {
          'jsonrpc': '2.0',
          'id': id,
          'result': {'tools': _getRegisteredTools()},
        };

      case 'tools/call':
        final name = params['name'] as String?;
        final args = params['arguments'] as Map<String, dynamic>? ?? {};
        if (name == null)
          return _err(id, -32602, 'Missing tool name in params');
        return _executeTool(id, name, args);

      case 'resources/list':
        return {
          'jsonrpc': '2.0',
          'id': id,
          'result': {'resources': _getResources()},
        };

      case 'resources/read':
        final uri = params['uri'] as String?;
        if (uri == null) return _err(id, -32602, 'Missing uri');
        return _readResource(id, uri);

      case 'prompts/list':
        return {
          'jsonrpc': '2.0',
          'id': id,
          'result': {'prompts': _getPrompts()},
        };

      default:
        return _err(id, -32601, 'Method not found: $method');
    }
  }

  List<Map<String, dynamic>> _getRegisteredTools() => [
    {
      'name': 'accept_incoming_ride',
      'description': 'Accepts incoming ride request for Captain.',
      'inputSchema': {
        'type': 'object',
        'properties': {
          'ride_id': {'type': 'string'},
        },
        'required': ['ride_id'],
      },
    },
    {
      'name': 'decline_incoming_ride',
      'description': 'Declines incoming ride request.',
      'inputSchema': {
        'type': 'object',
        'properties': {
          'reason': {'type': 'string'},
        },
      },
    },
    {
      'name': 'toggle_duty_status',
      'description': 'Toggles captain status between Online and Offline.',
      'inputSchema': {
        'type': 'object',
        'properties': {
          'is_online': {'type': 'boolean'},
        },
        'required': ['is_online'],
      },
    },
    {
      'name': 'get_captain_summary',
      'description': 'Returns daily earnings, completed trips, and rating.',
      'inputSchema': {'type': 'object', 'properties': {}},
    },
    {
      'name': 'get_active_ride',
      'description': 'Returns telemetry, passenger info, and start OTP.',
      'inputSchema': {'type': 'object', 'properties': {}},
    },
    {
      'name': 'start_pickup_navigation',
      'description': 'Starts navigation to customer pickup location.',
      'inputSchema': {
        'type': 'object',
        'properties': {
          'pickup_address': {'type': 'string'},
        },
      },
    },
    {
      'name': 'verify_passenger_otp',
      'description': 'Validates passenger 4-digit start OTP.',
      'inputSchema': {
        'type': 'object',
        'properties': {
          'otp': {'type': 'string'},
        },
        'required': ['otp'],
      },
    },
  ];

  Map<String, dynamic> _executeTool(
    dynamic id,
    String name,
    Map<String, dynamic> args,
  ) {
    dynamic payload;
    bool isError = false;

    switch (name) {
      case 'accept_incoming_ride':
        final rideId = args['ride_id'] ?? 'GJ-84920';
        activeRide?['status'] = 'accepted';
        payload = {
          'status': 'accepted',
          'ride_id': rideId,
          'fare': activeRide?['fare'] ?? 245.50,
          'passenger': activeRide?['passenger_name'] ?? 'mera passenger',
          'start_otp': activeRide?['otp'] ?? '5824',
        };
        break;

      case 'decline_incoming_ride':
        activeRide?['status'] = 'declined';
        payload = {
          'status': 'declined',
          'reason': args['reason'] ?? 'passed_by_captain',
        };
        break;

      case 'toggle_duty_status':
        isOnline = args['is_online'] as bool? ?? !isOnline;
        payload = {
          'duty_status': isOnline ? 'ONLINE' : 'OFFLINE',
          'is_online': isOnline,
        };
        break;

      case 'get_captain_summary':
        payload = {
          'earnings_today': earningsToday,
          'completed_trips': completedTripsToday,
          'captain_rating': captainRating,
          'is_online': isOnline,
          'wallet_balance': 3820.00,
        };
        break;

      case 'get_active_ride':
        payload = activeRide ?? {'status': 'no_active_ride'};
        break;

      case 'start_pickup_navigation':
        final addr =
            args['pickup_address'] ??
            activeRide?['pickup_address'] ??
            'Salt Lake';
        payload = {
          'navigation': 'active',
          'destination': addr,
          'eta_minutes': 4,
        };
        break;

      case 'verify_passenger_otp':
        final match =
            (args['otp'] as String?) == (activeRide?['otp'] ?? '5824');
        isError = !match;
        payload = {
          'verified': match,
          'message': match ? 'OTP verified.' : 'Invalid OTP.',
        };
        break;

      default:
        return _err(id, -32601, 'Unknown tool: $name');
    }

    return {
      'jsonrpc': '2.0',
      'id': id,
      'result': {
        'content': [
          {'type': 'text', 'text': jsonEncode(payload)},
        ],
        'isError': isError,
      },
    };
  }

  List<Map<String, dynamic>> _getResources() => [
    {
      'uri': 'captain://profile',
      'name': 'Captain Profile',
      'mimeType': 'application/json',
    },
    {
      'uri': 'captain://earnings',
      'name': 'Captain Earnings',
      'mimeType': 'application/json',
    },
    {
      'uri': 'captain://active_ride',
      'name': 'Active Ride',
      'mimeType': 'application/json',
    },
  ];

  Map<String, dynamic> _readResource(dynamic id, String uri) {
    dynamic data;
    if (uri == 'captain://profile') {
      data = {
        'name': 'Subrata Roy',
        'vehicle': 'WB 02 AK 4920',
        'rating': captainRating,
      };
    } else if (uri == 'captain://earnings') {
      data = {'today': earningsToday, 'wallet': 3820.00};
    } else if (uri == 'captain://active_ride') {
      data = activeRide ?? {};
    } else {
      return _err(id, -32602, 'Resource not found: $uri');
    }

    return {
      'jsonrpc': '2.0',
      'id': id,
      'result': {
        'contents': [
          {
            'uri': uri,
            'mimeType': 'application/json',
            'text': jsonEncode(data),
          },
        ],
      },
    };
  }

  List<Map<String, dynamic>> _getPrompts() => [
    {
      'name': 'captain_dispatch_copilot',
      'description': 'AI Co-pilot prompt for autonomous ride acceptance & route optimization.',
    },
    {
      'name': 'safety_incident_assistant',
      'description': 'Safety assistance prompt for emergency handling and dispatcher alerting.',
    },
  ];

  Map<String, dynamic> _err(dynamic id, int code, String msg) => {
    'jsonrpc': '2.0',
    'id': id,
    'error': {'code': code, 'message': msg},
  };
}
