import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class SecuritySection extends StatelessWidget {
  const SecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 900;
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                eyebrow: 'Security & Trust',
                title: 'Built around sensitive legal work.',
                description:
                    'We are designing Juridical Loop OS with privacy, access control, clear sources, and lawyer review in mind.',
              ),
              const SizedBox(height: 28),
              const FeatureGrid(items: securityFeatures),
              const SizedBox(height: 20),
              const _SecurityPriorityStrip(),
            ],
          );
          const visual = _SecurityVisual();

          if (stacked) {
            return Column(children: [copy, const SizedBox(height: 30), visual]);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 6, child: copy),
              const SizedBox(width: 42),
              const Expanded(flex: 4, child: visual),
            ],
          );
        },
      ),
    );
  }
}

class _SecurityPriorityStrip extends StatelessWidget {
  const _SecurityPriorityStrip();

  @override
  Widget build(BuildContext context) {
    final priorities = [
      (Icons.lock_outline, 'Privacy first'),
      (Icons.admin_panel_settings, 'Access control'),
      (Icons.fact_check, 'Source visibility'),
      (Icons.visibility_outlined, 'Review clarity'),
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final priority in priorities)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.70),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.deepNavy.withValues(alpha: 0.08),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(priority.$1, color: AppColors.teal, size: 17),
                const SizedBox(width: 8),
                Text(
                  priority.$2,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _SecurityVisual extends StatefulWidget {
  const _SecurityVisual();

  @override
  State<_SecurityVisual> createState() => _SecurityVisualState();
}

class _SecurityVisualState extends State<_SecurityVisual> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _hovered ? 1 : 0),
        duration: Motion.duration(context, 420),
        curve: Motion.curve,
        builder: (context, value, child) {
          return Transform.scale(scale: 1 + value * 0.018, child: child);
        },
        child: Container(
          constraints: const BoxConstraints(minHeight: 340),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: AppColors.deepNavy,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepNavy.withValues(alpha: 0.16),
                blurRadius: 30,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              for (final size in const [220.0, 156.0, 92.0])
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.86, end: 1),
                  duration: Motion.duration(context, 1400),
                  curve: Curves.easeInOut,
                  builder: (context, scale, _) {
                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              Container(
                width: 92,
                height: 92,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: AppColors.teal,
                  size: 42,
                ),
              ),
              const Positioned(
                top: 18,
                left: 12,
                child: _SecurityChip(label: 'Access controls'),
              ),
              const Positioned(
                right: 0,
                top: 92,
                child: _SecurityChip(label: 'Clear sources'),
              ),
              const Positioned(
                left: 0,
                bottom: 76,
                child: _SecurityChip(label: 'Private work'),
              ),
              const Positioned(
                right: 18,
                bottom: 18,
                child: _SecurityChip(label: 'Lawyer review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SecurityChip extends StatelessWidget {
  const _SecurityChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.11),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white.withValues(alpha: 0.88),
        ),
      ),
    );
  }
}
