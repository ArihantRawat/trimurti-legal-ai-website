import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/section_header.dart';

class ProductVisionSection extends StatelessWidget {
  const ProductVisionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedPage(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: Column(
          children: [
            const SectionHeader(
              eyebrow: 'Product vision',
              title: 'One workspace for the legal work behind the work.',
              description:
                  'Juridical Loop OS is being shaped around the flow from matter context to research, draft, review, and client-ready work.',
              centered: true,
            ),
            const SizedBox(height: 34),
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 940;
                const panel = _OperatingLayerVisual();
                const cards = _VisionCards();

                if (stacked) {
                  return Column(
                    children: [panel, const SizedBox(height: 18), cards],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 5, child: panel),
                    const SizedBox(width: 24),
                    Expanded(flex: 5, child: cards),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VisionCards extends StatelessWidget {
  const _VisionCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns =
            Breakpoints.isMobile(context) || constraints.maxWidth < 520 ? 1 : 2;
        final spacing = 14.0;
        final width = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - spacing) / 2;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            SizedBox(
              width: width,
              child: const _VisionCard(
                icon: Icons.source_outlined,
                title: 'Source-aware answers',
                description:
                    'Research and draft support should keep legal sources close to the work.',
                color: AppColors.teal,
              ),
            ),
            SizedBox(
              width: width,
              child: const _VisionCard(
                icon: Icons.hub_outlined,
                title: 'Matter context',
                description:
                    'Notes, versions, tasks, and review steps should stay connected to the matter.',
                color: AppColors.purple,
              ),
            ),
            SizedBox(
              width: width,
              child: const _VisionCard(
                icon: Icons.edit_note,
                title: 'Drafting flow',
                description:
                    'Move from facts and instructions to a clearer starting draft.',
                color: AppColors.blue,
              ),
            ),
            SizedBox(
              width: width,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.deepNavy,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Stealth by design',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'We are sharing the direction at a high level while we build with care.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.78),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OperatingLayerVisual extends StatelessWidget {
  const _OperatingLayerVisual();

  @override
  Widget build(BuildContext context) {
    final steps = [
      (Icons.folder_open, 'Matter context', AppColors.blue),
      (Icons.travel_explore, 'Research', AppColors.teal),
      (Icons.edit_document, 'Draft', AppColors.purple),
      (Icons.fact_check, 'Review', AppColors.amber),
    ];

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.16),
            blurRadius: 34,
            offset: const Offset(0, 22),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Operating layer',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            'A calm place for legal teams to move from input to reviewable work.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
          const SizedBox(height: 28),
          for (var i = 0; i < steps.length; i++) ...[
            _OperatingStep(
              icon: steps[i].$1,
              label: steps[i].$2,
              color: steps[i].$3,
              isLast: i == steps.length - 1,
            ),
          ],
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Text(
              'Planned around firm-specific context, visible sources, and lawyer review.',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.88),
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OperatingStep extends StatelessWidget {
  const _OperatingStep({
    required this.icon,
    required this.label,
    required this.color,
    required this.isLast,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.28)),
              ),
              child: Icon(icon, color: Colors.white, size: 19),
            ),
            if (!isLast)
              Container(
                width: 1,
                height: 28,
                color: Colors.white.withValues(alpha: 0.15),
              ),
          ],
        ),
        const SizedBox(width: 14),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class _VisionCard extends StatelessWidget {
  const _VisionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 18),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
