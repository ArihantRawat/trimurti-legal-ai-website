import 'package:flutter/material.dart';

class Motion {
  static bool reduce(BuildContext context) {
    final media = MediaQuery.maybeOf(context);
    return media?.disableAnimations == true ||
        media?.accessibleNavigation == true;
  }

  static Duration duration(BuildContext context, int milliseconds) {
    return reduce(context)
        ? Duration.zero
        : Duration(milliseconds: milliseconds);
  }

  static Curve get curve => Curves.easeOutCubic;
}

class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    required this.controller,
    required this.child,
    this.delay = Duration.zero,
    this.offset = 24,
    super.key,
  });

  final ScrollController controller;
  final Widget child;
  final Duration delay;
  final double offset;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didUpdateWidget(covariant RevealOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_checkVisibility);
      widget.controller.addListener(_checkVisibility);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkVisibility);
    super.dispose();
  }

  void _checkVisibility() {
    if (_visible || !mounted) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return;

    final top = box.localToGlobal(Offset.zero).dy;
    final viewport = MediaQuery.sizeOf(context).height;
    if (top < viewport * 0.9) {
      if (widget.delay == Duration.zero || Motion.reduce(context)) {
        setState(() => _visible = true);
      } else {
        Future<void>.delayed(widget.delay, () {
          if (mounted) setState(() => _visible = true);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Motion.reduce(context)) return widget.child;

    return AnimatedOpacity(
      duration: Motion.duration(context, 560),
      curve: Motion.curve,
      opacity: _visible ? 1 : 0,
      child: AnimatedSlide(
        duration: Motion.duration(context, 560),
        curve: Motion.curve,
        offset: _visible ? Offset.zero : Offset(0, widget.offset / 100),
        child: widget.child,
      ),
    );
  }
}
