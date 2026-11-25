import 'package:material_ui/material_ui.dart';

class RadarMapPainter extends CustomPainter {
  final double pulseProgress;
  final bool isAccepted;

  RadarMapPainter({
    this.pulseProgress = 0.5,
    this.isAccepted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Subtle warm grid lines (representing map roads/blocks)
    final gridPaint = Paint()
      ..color = const Color(0xFFEBE5DB).withValues(alpha: 0.65)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double step = 32.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // 2. Secondary diagonal road network
    final roadPaint = Paint()
      ..color = const Color(0xFFDED7C9).withValues(alpha: 0.5)
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final roadPath = Path()
      ..moveTo(0, size.height * 0.75)
      ..lineTo(size.width * 0.45, size.height * 0.55)
      ..lineTo(size.width, size.height * 0.3);
    canvas.drawPath(roadPath, roadPaint);

    final roadPath2 = Path()
      ..moveTo(size.width * 0.2, 0)
      ..lineTo(size.width * 0.35, size.height)
      ..moveTo(size.width * 0.7, 0)
      ..lineTo(size.width * 0.6, size.height);
    canvas.drawPath(roadPath2, roadPaint);

    // 3. Captain location (Point A)
    final captainPos = Offset(size.width * 0.28, size.height * 0.55);
    // Pickup location (Point B)
    final pickupPos = Offset(size.width * 0.52, size.height * 0.38);
    // Dropoff location (Point C)
    final dropoffPos = Offset(size.width * 0.78, size.height * 0.25);

    // 4. Draw route path between Captain -> Pickup -> Dropoff
    final routePaint = Paint()
      ..color = const Color(0xFF075B30) // deepForestGreen
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final routeGlowPaint = Paint()
      ..color = const Color(0xFF075B30).withValues(alpha: 0.2)
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final activeRoute = Path()
      ..moveTo(captainPos.dx, captainPos.dy)
      ..quadraticBezierTo(
        size.width * 0.38,
        size.height * 0.42,
        pickupPos.dx,
        pickupPos.dy,
      )
      ..quadraticBezierTo(
        size.width * 0.65,
        size.height * 0.28,
        dropoffPos.dx,
        dropoffPos.dy,
      );

    canvas.drawPath(activeRoute, routeGlowPaint);
    canvas.drawPath(activeRoute, routePaint);

    // 5. Radar pulse circle around pickup
    final pulsePaint = Paint()
      ..color = const Color(0xFF159447).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(pickupPos, 20 + (pulseProgress * 22), pulsePaint);
    canvas.drawCircle(pickupPos, 36 + (pulseProgress * 14), pulsePaint..strokeWidth = 1.0);

    // 6. Draw Captain Pin
    _drawCaptainMarker(canvas, captainPos);

    // 7. Draw Pickup Pin (Fresh Green)
    _drawPinMarker(
      canvas,
      pickupPos,
      const Color(0xFF159447),
      'P',
      Colors.white,
    );

    // 8. Draw Dropoff Pin (Near Black / Forest Green)
    _drawPinMarker(
      canvas,
      dropoffPos,
      const Color(0xFF171A18),
      'D',
      const Color(0xFFC9A55A),
    );
  }

  void _drawCaptainMarker(Canvas canvas, Offset pos) {
    // Soft shadow
    canvas.drawCircle(
      pos + const Offset(0, 3),
      14,
      Paint()..color = Colors.black.withValues(alpha: 0.15),
    );

    // Outer white halo
    canvas.drawCircle(
      pos,
      13,
      Paint()..color = Colors.white,
    );

    // Inner Forest Green core
    canvas.drawCircle(
      pos,
      9,
      Paint()..color = const Color(0xFF075B30),
    );

    // Center directional heading tip
    final headingPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final tipPath = Path()
      ..moveTo(pos.dx, pos.dy - 6)
      ..lineTo(pos.dx - 4, pos.dy + 3)
      ..lineTo(pos.dx + 4, pos.dy + 3)
      ..close();
    canvas.drawPath(tipPath, headingPaint);
  }

  void _drawPinMarker(
    Canvas canvas,
    Offset pos,
    Color bg,
    String label,
    Color textColor,
  ) {
    // Shadow
    canvas.drawCircle(
      pos + const Offset(0, 2),
      13,
      Paint()..color = Colors.black.withValues(alpha: 0.2),
    );

    // Pin circle
    canvas.drawCircle(
      pos,
      12,
      Paint()..color = bg,
    );

    // White ring
    canvas.drawCircle(
      pos,
      12,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );

    // Text letter
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
      canvas,
      Offset(pos.dx - (textPainter.width / 2), pos.dy - (textPainter.height / 2)),
    );
  }

  @override
  bool shouldRepaint(covariant RadarMapPainter oldDelegate) {
    return oldDelegate.pulseProgress != pulseProgress || oldDelegate.isAccepted != isAccepted;
  }
}
