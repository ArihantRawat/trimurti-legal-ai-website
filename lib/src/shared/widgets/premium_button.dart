import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/motion/motion.dart';
import '../../core/theme/app_theme.dart';

class PremiumButton extends StatefulWidget {
  const PremiumButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.secondary = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool secondary;

  @override
  State<PremiumButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PremiumButton> {
  bool _hovered = false;
  bool _pressed = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final reduce = Motion.reduce(context);
    final foreground = widget.secondary ? AppColors.deepNavy : Colors.white;
    final background = widget.secondary
        ? Colors.white.withValues(alpha: 0.72)
        : AppColors.deepNavy;

    return FocusableActionDetector(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
        SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
      },
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onPressed();
            return null;
          },
        ),
      },
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      mouseCursor: SystemMouseCursors.click,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() {
          _hovered = false;
          _pressed = false;
        }),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          child: AnimatedScale(
            duration: Motion.duration(context, 150),
            curve: Curves.easeOut,
            scale: reduce
                ? 1
                : _pressed
                ? 0.98
                : _hovered
                ? 1.025
                : 1,
            child: Semantics(
              button: true,
              label: widget.label,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onPressed,
                  borderRadius: BorderRadius.circular(999),
                  child: AnimatedContainer(
                    duration: Motion.duration(context, 180),
                    curve: Motion.curve,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: _focused
                            ? AppColors.blue
                            : widget.secondary
                            ? Colors.white.withValues(alpha: 0.9)
                            : AppColors.deepNavy,
                        width: _focused ? 2 : 1,
                      ),
                      boxShadow: [
                        if (!widget.secondary)
                          BoxShadow(
                            color: AppColors.deepNavy.withValues(
                              alpha: _hovered ? 0.24 : 0.16,
                            ),
                            blurRadius: _hovered ? 22 : 14,
                            offset: const Offset(0, 12),
                          ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.label,
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: foreground),
                        ),
                        if (widget.icon != null) ...[
                          const SizedBox(width: 10),
                          Icon(widget.icon, size: 18, color: foreground),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
