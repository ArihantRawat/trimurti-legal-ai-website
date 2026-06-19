import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/premium_button.dart';

class SiteNavBar extends StatelessWidget {
  const SiteNavBar({
    required this.scrolled,
    required this.onHero,
    required this.onProduct,
    required this.onSecurity,
    required this.onFaq,
    required this.onContact,
    super.key,
  });

  final bool scrolled;
  final VoidCallback onHero;
  final VoidCallback onProduct;
  final VoidCallback onSecurity;
  final VoidCallback onFaq;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final compact = !Breakpoints.isDesktop(context);
    final links = <_NavLink>[
      _NavLink('Product', onProduct),
      _NavLink('Security', onSecurity),
      _NavLink('FAQ', onFaq),
    ];
    final compactLinks = <_NavLink>[
      ...links,
      _NavLink('Contact us', onContact),
    ];

    return Semantics(
      container: true,
      label: 'Primary navigation',
      child: AnimatedContainer(
        duration: Motion.duration(context, 240),
        curve: Motion.curve,
        margin: EdgeInsets.only(top: compact ? 8 : 12),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 12 : 16,
          vertical: compact ? 8 : 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: scrolled ? 0.84 : 0.64),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.deepNavy.withValues(alpha: scrolled ? 0.13 : 0.07),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(
                alpha: scrolled ? 0.13 : 0.06,
              ),
              blurRadius: scrolled ? 26 : 14,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Row(
          children: [
            InkWell(
              onTap: onHero,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    const BrandMark(heroTag: 'trimurti-mark'),
                    const SizedBox(width: 10),
                    Text(
                      'Trimurti',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 17,
                        color: AppColors.deepNavy,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (compact) ...[
              const SizedBox(width: 12),
              PopupMenuButton<_NavLink>(
                tooltip: 'Open navigation menu',
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.deepNavy,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.menu, color: Colors.white, size: 20),
                ),
                onSelected: (link) => link.onTap(),
                itemBuilder: (context) => [
                  for (final link in compactLinks)
                    PopupMenuItem(value: link, child: Text(link.label)),
                ],
              ),
            ] else ...[
              const Spacer(),
              for (final link in links)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: TextButton(
                    onPressed: link.onTap,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.ink,
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(link.label),
                  ),
                ),
              const SizedBox(width: 10),
              PremiumButton(
                label: 'Contact us',
                icon: Icons.arrow_forward,
                onPressed: onContact,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NavLink {
  const _NavLink(this.label, this.onTap);

  final String label;
  final VoidCallback onTap;
}
