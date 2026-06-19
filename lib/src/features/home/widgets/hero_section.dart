import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/premium_button.dart';
import 'stealth_system_panel.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    required this.onContact,
    required this.onExplore,
    super.key,
  });

  final VoidCallback onContact;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return ConstrainedPage(
      child: Padding(
        padding: EdgeInsets.only(
          top: mobile ? 56 : 88,
          bottom: mobile ? 56 : 86,
        ),
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 980;
                final content = _HeroCopy(
                  onContact: onContact,
                  onExplore: onExplore,
                );
                final panel = const StealthSystemPanel(compact: true);
                final stackedMockup = mobile
                    ? Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: panel,
                        ),
                      )
                    : panel;

                if (stacked) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content,
                      const SizedBox(height: 42),
                      stackedMockup,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 10, child: content),
                    const SizedBox(width: 44),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: panel,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 38),
            const _HeroMetrics(),
          ],
        ),
      ),
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({required this.onContact, required this.onExplore});

  final VoidCallback onContact;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: 'Trust statement',
          child: Container(
            width: mobile ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.70),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.teal.withValues(alpha: 0.18)),
            ),
            child: Row(
              mainAxisSize: mobile ? MainAxisSize.max : MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: AppColors.teal, size: 17),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    mobile
                        ? 'Stealth legal AI company. MIT Sandbox backed.'
                        : 'Stealth legal AI company. Backed by the MIT Sandbox Innovation Fund Program.',
                    softWrap: true,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: AppColors.deepNavy),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        Text(
          mobile
              ? 'Legal work,\nwith more clarity'
              : 'Legal work, with more clarity',
          softWrap: true,
          textWidthBasis: TextWidthBasis.parent,
          style: Theme.of(
            context,
          ).textTheme.displayLarge?.copyWith(fontSize: mobile ? 36 : 66),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: mobile ? 330 : 690),
          child: Text(
            'Trimurti is building Juridical Loop OS, a focused AI workspace for modern law firms.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: mobile ? 17 : 20,
              color: AppColors.ink,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            PremiumButton(
              label: 'Contact us',
              icon: Icons.arrow_forward,
              onPressed: onContact,
            ),
            PremiumButton(
              label: 'View product vision',
              icon: Icons.dashboard_customize,
              secondary: true,
              onPressed: onExplore,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroMetrics extends StatelessWidget {
  const _HeroMetrics();

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final metrics = [
      ('Drafting', 'Cleaner first drafts'),
      ('Research', 'Clear sources'),
      ('Matters', 'Work in one place'),
      ('Review', 'Lawyer controlled'),
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        for (final metric in metrics)
          Container(
            width: mobile ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.62),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColors.deepNavy.withValues(alpha: 0.09),
              ),
            ),
            child: mobile
                ? Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.teal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        metric.$1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          metric.$2,
                          style: Theme.of(context).textTheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.teal,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        metric.$1,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        metric.$2,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
          ),
      ],
    );
  }
}
