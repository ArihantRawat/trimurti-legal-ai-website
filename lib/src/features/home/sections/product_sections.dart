import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/models/site_models.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class WorkflowSection extends StatelessWidget {
  const WorkflowSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProductSection(
      eyebrow: 'Workflow direction',
      title: 'A clearer workspace for matter work.',
      description:
          'We are exploring how drafting, comments, checklists, messages, and versions can live closer to the matter.',
      items: workflowFeatures,
      panelTitle: 'Matter work',
      panelText:
          'The goal is to help teams see the current draft, the next step, and the important context without jumping between tools.',
    );
  }
}

class ResearchSection extends StatelessWidget {
  const ResearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ProductSection(
      eyebrow: 'Research direction',
      title: 'Research that is easier to review.',
      description:
          'We are exploring research flows that make sources easier to find, compare, and turn into careful work product.',
      items: researchFeatures,
      panelTitle: 'Research work',
      panelText:
          'The goal is to keep useful sources, review notes, and draft memo structure close together.',
      reverse: true,
    );
  }
}

class _ProductSection extends StatelessWidget {
  const _ProductSection({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.items,
    required this.panelTitle,
    required this.panelText,
    this.reverse = false,
  });

  final String eyebrow;
  final String title;
  final String description;
  final List<FeatureItem> items;
  final String panelTitle;
  final String panelText;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 940;
          final copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeader(
                eyebrow: eyebrow,
                title: title,
                description: description,
              ),
              const SizedBox(height: 28),
              FeatureGrid(items: items, compact: true),
            ],
          );
          final panel = _DirectionPanel(
            title: panelTitle,
            text: panelText,
            items: items,
          );

          if (stacked) {
            return Column(children: [copy, const SizedBox(height: 30), panel]);
          }

          final children = <Widget>[
            Expanded(flex: 5, child: copy),
            const SizedBox(width: 42),
            Expanded(flex: 6, child: panel),
          ];

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: reverse ? children.reversed.toList() : children,
          );
        },
      ),
    );
  }
}

class _DirectionPanel extends StatelessWidget {
  const _DirectionPanel({
    required this.title,
    required this.text,
    required this.items,
  });

  final String title;
  final String text;
  final List<FeatureItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.10),
            blurRadius: 30,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final item in items)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: item.color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: item.color.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Text(
                    item.title,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.deepNavy,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
