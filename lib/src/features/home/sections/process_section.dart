import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/models/site_models.dart';
import '../../../shared/widgets/hover_lift_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      child: Column(
        children: [
          const SectionHeader(
            eyebrow: 'How it works',
            title: 'A practical path to learn more and shape what comes next.',
            description:
                'We want early conversations to be based on real legal work.',
            centered: true,
          ),
          const SizedBox(height: 38),
          LayoutBuilder(
            builder: (context, constraints) {
              final mobile = constraints.maxWidth < 740;
              if (mobile) {
                return Column(
                  children: [
                    for (final step in howItWorks) ...[
                      _TimelineCard(step: step),
                      if (step != howItWorks.last) const SizedBox(height: 14),
                    ],
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final step in howItWorks)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: _TimelineCard(step: step),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  const _TimelineCard({required this.step});

  final TimelineStep step;

  @override
  Widget build(BuildContext context) {
    return HoverLiftCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.deepNavy,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                step.label,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(step.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(step.description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
