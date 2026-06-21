import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/theme/app_theme.dart';

class AmbientBackground extends StatefulWidget {
  const AmbientBackground({required this.pointer, super.key});

  final Offset pointer;

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Motion.reduce(context)) _controller.stop();

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _AmbientPainter(
            progress: Motion.reduce(context) ? 0 : _controller.value,
            pointer: widget.pointer,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _AmbientPainter extends CustomPainter {
  const _AmbientPainter({required this.progress, required this.pointer});

  final double progress;
  final Offset pointer;

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.offWhite,
          Color(0xFFEAF4F6),
          Color(0xFFF6F0E8),
          Color(0xFFF8F8F6),
        ],
        stops: [0, 0.34, 0.70, 1],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, base);

    final pointerCenter = Offset(
      pointer.dx * size.width,
      pointer.dy * size.height,
    );
    final pointerPaint = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.teal.withValues(alpha: 0.08),
              AppColors.blue.withValues(alpha: 0.020),
              Colors.transparent,
            ],
            stops: const [0, 0.30, 1],
          ).createShader(
            Rect.fromCircle(
              center: pointerCenter,
              radius: size.shortestSide * 0.075,
            ),
          );
    canvas.drawCircle(pointerCenter, size.shortestSide * 0.075, pointerPaint);

    _drawArchitecturalWash(canvas, size);
    _drawPaperRules(canvas, size);
    _drawCitationRibbons(canvas, size);
    _drawReferenceMap(canvas, size, pointerCenter);
  }

  void _drawArchitecturalWash(Canvas canvas, Size size) {
    final t = progress * math.pi * 2;
    final washes = [
      (
        begin: Offset(size.width * -0.08, size.height * 0.12),
        end: Offset(size.width * 1.05, size.height * 0.38),
        color: AppColors.blue.withValues(alpha: 0.030),
        width: size.width < 720 ? 42.0 : 70.0,
      ),
      (
        begin: Offset(size.width * 0.18, size.height * 0.92),
        end: Offset(size.width * 1.12, size.height * 0.22),
        color: AppColors.amber.withValues(alpha: 0.032),
        width: size.width < 720 ? 34.0 : 58.0,
      ),
      (
        begin: Offset(size.width * -0.05, size.height * 0.70),
        end: Offset(size.width * 0.88, size.height * 1.04),
        color: AppColors.teal.withValues(alpha: 0.030),
        width: size.width < 720 ? 30.0 : 50.0,
      ),
    ];

    for (final wash in washes) {
      final drift = Offset(math.sin(t) * 18, math.cos(t * 0.8) * 14);
      canvas.drawLine(
        wash.begin + drift,
        wash.end - drift,
        Paint()
          ..color = wash.color
          ..strokeWidth = wash.width
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  void _drawPaperRules(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = AppColors.deepNavy.withValues(alpha: 0.026)
      ..strokeWidth = 1;
    final step = size.width < 720 ? 36.0 : 48.0;
    final drift = progress * step;
    for (double x = -step + drift; x < size.width + step; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = -step + drift * 0.55; y < size.height + step; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final rulePaint = Paint()
      ..color = AppColors.amber.withValues(alpha: 0.030)
      ..strokeWidth = 1.2;
    for (double y = 132; y < size.height; y += 184) {
      final wave = math.sin(progress * math.pi * 2 + y * 0.01) * 8;
      canvas.drawLine(
        Offset(0, y + wave),
        Offset(size.width, y - wave),
        rulePaint,
      );
    }
  }

  void _drawCitationRibbons(Canvas canvas, Size size) {
    final t = progress * math.pi * 2;
    final ribbons = [
      (
        color: AppColors.blue.withValues(alpha: 0.045),
        y: size.height * 0.24,
        amp: 28.0,
      ),
      (
        color: AppColors.teal.withValues(alpha: 0.040),
        y: size.height * 0.58,
        amp: 34.0,
      ),
      (
        color: AppColors.purple.withValues(alpha: 0.026),
        y: size.height * 0.82,
        amp: 24.0,
      ),
    ];

    for (final ribbon in ribbons) {
      final path = Path()..moveTo(-80, ribbon.y + math.sin(t) * ribbon.amp);
      path.cubicTo(
        size.width * 0.22,
        ribbon.y - ribbon.amp * 2 + math.cos(t) * 10,
        size.width * 0.52,
        ribbon.y + ribbon.amp * 2,
        size.width + 80,
        ribbon.y + math.sin(t + 1.4) * ribbon.amp,
      );

      canvas.drawPath(
        path,
        Paint()
          ..color = ribbon.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = size.width < 720 ? 18 : 28
          ..strokeCap = StrokeCap.round,
      );
      canvas.drawPath(
        path,
        Paint()
          ..color = AppColors.deepNavy.withValues(alpha: 0.035)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  void _drawReferenceMap(Canvas canvas, Size size, Offset pointerCenter) {
    final points = <Offset>[
      Offset(size.width * 0.13, size.height * 0.18),
      Offset(size.width * 0.31, size.height * 0.30),
      Offset(size.width * 0.49, size.height * 0.20),
      Offset(size.width * 0.73, size.height * 0.34),
      Offset(size.width * 0.86, size.height * 0.18),
      Offset(size.width * 0.22, size.height * 0.66),
      Offset(size.width * 0.54, size.height * 0.70),
      Offset(size.width * 0.78, size.height * 0.58),
    ];

    final linePaint = Paint()
      ..color = AppColors.deepNavy.withValues(alpha: 0.045)
      ..strokeWidth = 1;
    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], linePaint);
    }

    for (final point in points) {
      final distance = (point - pointerCenter).distance;
      final active = distance < size.shortestSide * 0.26;
      canvas.drawCircle(
        point,
        active ? 3.6 : 2.4,
        Paint()
          ..color = (active ? AppColors.teal : AppColors.deepNavy).withValues(
            alpha: active ? 0.28 : 0.12,
          ),
      );
      canvas.drawCircle(
        point,
        active ? 10 : 7,
        Paint()
          ..color = (active ? AppColors.teal : AppColors.deepNavy).withValues(
            alpha: active ? 0.050 : 0.025,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _AmbientPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.pointer != pointer;
  }
}
