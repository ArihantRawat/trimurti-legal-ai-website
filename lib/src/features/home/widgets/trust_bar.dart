import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';

class TrustBar extends StatelessWidget {
  const TrustBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedPage(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 72),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.74),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.deepNavy.withValues(alpha: 0.10),
            ),
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final badge in trustBadges)
                Container(
                  width: Breakpoints.isMobile(context) ? double.infinity : null,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.deepNavy.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.teal,
                        size: 17,
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          badge,
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
