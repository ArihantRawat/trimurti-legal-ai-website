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
      duration: const Duration(seconds: 18),
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
        colors: [AppColors.offWhite, Color(0xFFEAF1F4), Color(0xFFF8F8F6)],
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
              AppColors.blue.withValues(alpha: 0.08),
              AppColors.teal.withValues(alpha: 0.03),
              Colors.transparent,
            ],
            stops: const [0, 0.36, 1],
          ).createShader(
            Rect.fromCircle(
              center: pointerCenter,
              radius: size.shortestSide * 0.085,
            ),
          );
    canvas.drawCircle(pointerCenter, size.shortestSide * 0.085, pointerPaint);

    _drawLightField(
      canvas,
      size,
      Offset(
        size.width * (0.18 + math.sin(progress * math.pi * 2) * 0.025),
        size.height * 0.18,
      ),
      AppColors.blue.withValues(alpha: 0.12),
      size.width * 0.34,
    );
    _drawLightField(
      canvas,
      size,
      Offset(
        size.width * 0.86,
        size.height * (0.45 + math.cos(progress * math.pi * 2) * 0.035),
      ),
      AppColors.purple.withValues(alpha: 0.08),
      size.width * 0.28,
    );
    _drawLightField(
      canvas,
      size,
      Offset(size.width * 0.42, size.height * 0.82),
      AppColors.teal.withValues(alpha: 0.10),
      size.width * 0.30,
    );

    final gridPaint = Paint()
      ..color = AppColors.deepNavy.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    final step = size.width < 720 ? 36.0 : 48.0;
    final drift = progress * step;
    for (double x = -step + drift; x < size.width + step; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = -step + drift * 0.55; y < size.height + step; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  void _drawLightField(
    Canvas canvas,
    Size size,
    Offset center,
    Color color,
    double radius,
  ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withValues(alpha: color.a * 0.3),
          Colors.transparent,
        ],
        stops: const [0, 0.38, 1],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _AmbientPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.pointer != pointer;
  }
}
