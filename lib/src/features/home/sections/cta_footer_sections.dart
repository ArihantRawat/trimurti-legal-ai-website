import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/brand_mark.dart';
import '../../../shared/widgets/premium_button.dart';
import '../widgets/feature_grid.dart';

class FinalCtaSection extends StatelessWidget {
  const FinalCtaSection({required this.onContact, super.key});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      child: Container(
        padding: EdgeInsets.all(Breakpoints.isMobile(context) ? 28 : 46),
        decoration: BoxDecoration(
          color: AppColors.deepNavy,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(alpha: 0.18),
              blurRadius: 34,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 760;
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Want to learn more?',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontSize: Breakpoints.isMobile(context) ? 34 : 48,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Send us a note. We would like to hear what your legal team is trying to improve.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white.withValues(alpha: 0.78),
                  ),
                ),
              ],
            );
            final action = PremiumButton(
              label: 'Contact us',
              icon: Icons.arrow_forward,
              secondary: true,
              onPressed: onContact,
            );

            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [copy, const SizedBox(height: 26), action],
              );
            }
            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 32),
                action,
              ],
            );
          },
        ),
      ),
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({
    required this.onAbout,
    required this.onContact,
    required this.onWorkflow,
    required this.onResearch,
    required this.onFaq,
    required this.onSecurity,
    super.key,
  });

  final VoidCallback onAbout;
  final VoidCallback onContact;
  final VoidCallback onWorkflow;
  final VoidCallback onResearch;
  final VoidCallback onFaq;
  final VoidCallback onSecurity;

  @override
  Widget build(BuildContext context) {
    final columns = <String, List<_FooterLink>>{
      'Company': [
        _FooterLink('About', onAbout),
        _FooterLink('Contact', onContact),
      ],
      'Product': [
        _FooterLink('Product vision', onWorkflow),
        _FooterLink('Research direction', onResearch),
      ],
      'Resources': [
        _FooterLink('FAQ', onFaq),
        _FooterLink('Security', onSecurity),
      ],
    };

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.50),
        border: Border(
          top: BorderSide(color: AppColors.deepNavy.withValues(alpha: 0.08)),
        ),
      ),
      child: ConstrainedPage(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 42),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 760;
              final brand = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BrandMark(),
                      const SizedBox(width: 10),
                      Text(
                        'Trimurti',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    '\u00A9 2026 Trimurti. All rights reserved.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
              final links = Wrap(
                spacing: 56,
                runSpacing: 28,
                children: [
                  for (final entry in columns.entries)
                    SizedBox(
                      width: 130,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          const SizedBox(height: 12),
                          for (final link in entry.value)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: TextButton(
                                onPressed: link.onPressed,
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  foregroundColor: AppColors.muted,
                                ),
                                child: Text(link.label),
                              ),
                            ),
                        ],
                      ),
                    ),
                ],
              );

              if (stacked) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [brand, const SizedBox(height: 30), links],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: brand),
                  links,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FooterLink {
  const _FooterLink(this.label, this.onPressed);

  final String label;
  final VoidCallback onPressed;
}
