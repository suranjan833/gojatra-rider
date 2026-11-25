import 'package:flutter_test/flutter_test.dart';
import '../bin/mcp_server.dart';

void main() {
  group('GoJatraMcpServer JSON-RPC 2.0 Protocol Tests', () {
    late GoJatraMcpServer server;

    setUp(() {
      server = GoJatraMcpServer();
    });

    test('initialize returns protocol version and capabilities', () async {
      final response = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 1,
        'method': 'initialize',
        'params': {
          'protocolVersion': '2024-11-05',
          'capabilities': {'tools': {}},
          'clientInfo': {'name': 'test-client', 'version': '1.0.0'},
        },
      });

      expect(response, isNotNull);
      expect(response!['id'], 1);
      final result = response['result'] as Map<String, dynamic>;
      expect(result['protocolVersion'], '2024-11-05');
      expect(result['serverInfo']['name'], 'go-jatra-captain-mcp');
      expect(result['capabilities']['tools'], isNotNull);
    });

    test('tools/list returns 7 registered captain tools', () async {
      final response = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 2,
        'method': 'tools/list',
      });

      expect(response, isNotNull);
      final tools = response!['result']['tools'] as List<dynamic>;
      expect(tools.length, 7);

      final toolNames = tools.map((t) => t['name'] as String).toList();
      expect(toolNames, contains('accept_incoming_ride'));
      expect(toolNames, contains('decline_incoming_ride'));
      expect(toolNames, contains('toggle_duty_status'));
      expect(toolNames, contains('get_captain_summary'));
      expect(toolNames, contains('get_active_ride'));
      expect(toolNames, contains('start_pickup_navigation'));
      expect(toolNames, contains('verify_passenger_otp'));
    });

    test('tools/call accept_incoming_ride returns accepted status and OTP', () async {
      final response = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 3,
        'method': 'tools/call',
        'params': {
          'name': 'accept_incoming_ride',
          'arguments': {'ride_id': 'GJ-84920'},
        },
      });

      expect(response, isNotNull);
      expect(response!['id'], 3);
      final result = response['result'] as Map<String, dynamic>;
      expect(result['isError'], isFalse);

      final content = result['content'] as List<dynamic>;
      expect(content.first['text'], contains('"status":"accepted"'));
      expect(content.first['text'], contains('"start_otp":"5824"'));
    });

    test('tools/call verify_passenger_otp validates correct code', () async {
      final validResponse = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 4,
        'method': 'tools/call',
        'params': {
          'name': 'verify_passenger_otp',
          'arguments': {'otp': '5824'},
        },
      });

      expect(validResponse!['result']['isError'], isFalse);
      expect(validResponse['result']['content'].first['text'], contains('"verified":true'));

      final invalidResponse = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 5,
        'method': 'tools/call',
        'params': {
          'name': 'verify_passenger_otp',
          'arguments': {'otp': '0000'},
        },
      });

      expect(invalidResponse!['result']['isError'], isTrue);
      expect(invalidResponse['result']['content'].first['text'], contains('"verified":false'));
    });

    test('resources/list and resources/read return captain metadata', () async {
      final listResp = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 6,
        'method': 'resources/list',
      });
      final resources = listResp!['result']['resources'] as List<dynamic>;
      expect(resources.length, 3);

      final readResp = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 7,
        'method': 'resources/read',
        'params': {'uri': 'captain://profile'},
      });
      final contents = readResp!['result']['contents'] as List<dynamic>;
      expect(contents.first['text'], contains('Subrata Roy'));
      expect(contents.first['text'], contains('WB 02 AK 4920'));
    });

    test('prompts/list returns captain dispatch prompts', () async {
      final resp = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 8,
        'method': 'prompts/list',
      });
      final prompts = resp!['result']['prompts'] as List<dynamic>;
      expect(prompts.length, 2);
      expect(prompts.first['name'], 'captain_dispatch_copilot');
    });

    test('unknown method returns -32601 JSON-RPC error', () async {
      final resp = await server.handleJsonRpc({
        'jsonrpc': '2.0',
        'id': 9,
        'method': 'non_existent_method',
      });
      expect(resp!['error']['code'], -32601);
    });
  });
}
