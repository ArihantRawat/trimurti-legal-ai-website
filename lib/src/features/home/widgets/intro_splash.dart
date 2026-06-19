import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/platform/visit_gate.dart';
import '../../../core/theme/app_theme.dart';

class IntroSplash extends StatefulWidget {
  const IntroSplash({super.key});

  @override
  State<IntroSplash> createState() => _IntroSplashState();
}

class _IntroSplashState extends State<IntroSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _show = false;
  bool _removed = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || Motion.reduce(context) || VisitGate.hasSeenIntro()) {
        VisitGate.markIntroSeen();
        return;
      }
      VisitGate.markIntroSeen();
      setState(() {
        _show = true;
        _removed = false;
      });
      _controller.forward();
      Future<void>.delayed(const Duration(milliseconds: 2600), () {
        if (!mounted) return;
        setState(() => _show = false);
      });
      Future<void>.delayed(const Duration(milliseconds: 3100), () {
        if (!mounted) return;
        setState(() => _removed = true);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_removed) return const SizedBox.shrink();

    return IgnorePointer(
      ignoring: !_show,
      child: AnimatedOpacity(
        duration: Motion.duration(context, 520),
        curve: Curves.easeInOutCubic,
        opacity: _show ? 1 : 0,
        child: Container(
          color: AppColors.deepNavy,
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final t = _controller.value;
                final nameOpacity = CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.08, 0.42, curve: Curves.easeOutCubic),
                ).value;
                final lineWidth = CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.36, 0.68, curve: Curves.easeOutCubic),
                ).value;
                final subtitleOpacity = CurvedAnimation(
                  parent: _controller,
                  curve: const Interval(0.52, 0.86, curve: Curves.easeOutCubic),
                ).value;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: Offset(0, 18 * (1 - nameOpacity)),
                      child: Opacity(
                        opacity: nameOpacity,
                        child: Text(
                          'Trimurti',
                          style: Theme.of(context).textTheme.displayMedium
                              ?.copyWith(color: Colors.white, fontSize: 62),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 1,
                      width: 240 * lineWidth,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.teal.withValues(alpha: 0.92),
                            AppColors.blue.withValues(alpha: 0.92),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Transform.translate(
                      offset: Offset(0, 14 * (1 - subtitleOpacity)),
                      child: Opacity(
                        opacity: subtitleOpacity,
                        child: Text(
                          'AI legal company',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.78),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 34),
                    Opacity(
                      opacity: (t * 1.2).clamp(0, 1),
                      child: SizedBox(
                        width: 42,
                        height: 42,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.teal.withValues(alpha: 0.78),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
