import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';

class TrustBar extends StatelessWidget {
  const TrustBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return ConstrainedPage(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 72),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(mobile ? 18 : 22),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.74),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.deepNavy.withValues(alpha: 0.10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Trust signals',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 14),
              if (mobile)
                Column(
                  children: [
                    for (var i = 0; i < trustSignals.length; i++) ...[
                      _SignalBadge(label: trustSignals[i], wide: true),
                      if (i != trustSignals.length - 1)
                        const SizedBox(height: 10),
                    ],
                  ],
                )
              else
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final signal in trustSignals)
                      _SignalBadge(label: signal, wide: false),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignalBadge extends StatelessWidget {
  const _SignalBadge({required this.label, required this.wide});

  final String label;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide ? double.infinity : null,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: wide ? MainAxisSize.max : MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: AppColors.teal, size: 17),
          const SizedBox(width: 8),
          if (wide)
            Expanded(
              child: Text(
                label,
                maxLines: 2,
                softWrap: true,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 13),
              ),
            )
          else
            Flexible(
              child: Text(
                label,
                softWrap: true,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }
}
