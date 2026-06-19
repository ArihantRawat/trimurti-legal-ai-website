import 'package:flutter/material.dart';

import '../../core/motion/motion.dart';
import '../../core/theme/app_theme.dart';

class HoverLiftCard extends StatefulWidget {
  const HoverLiftCard({
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.background = Colors.white,
    this.borderColor = AppColors.line,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsets padding;
  final Color background;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  State<HoverLiftCard> createState() => _HoverLiftCardState();
}

class _HoverLiftCardState extends State<HoverLiftCard> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final reduce = Motion.reduce(context);
    final lifted = (_hovered || _focused) && !reduce;

    return FocusableActionDetector(
      enabled: widget.onTap != null,
      actions: widget.onTap == null
          ? const {}
          : {
              ActivateIntent: CallbackAction<ActivateIntent>(
                onInvoke: (_) {
                  widget.onTap!();
                  return null;
                },
              ),
            },
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      mouseCursor: widget.onTap == null
          ? MouseCursor.defer
          : SystemMouseCursors.click,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: AnimatedContainer(
          duration: Motion.duration(context, 220),
          curve: Motion.curve,
          transform: Matrix4.translationValues(0, lifted ? -6 : 0, 0),
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _focused ? AppColors.blue : widget.borderColor,
              width: _focused ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepNavy.withValues(
                  alpha: lifted ? 0.13 : 0.06,
                ),
                blurRadius: lifted ? 30 : 16,
                offset: Offset(0, lifted ? 18 : 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(8),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
