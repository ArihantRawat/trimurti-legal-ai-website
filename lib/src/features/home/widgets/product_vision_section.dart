import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/section_header.dart';
import 'stealth_system_panel.dart';

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
              title: 'What we are building first.',
              description:
                  'A private legal AI workspace shaped around context, sources, and review.',
              centered: true,
            ),
            const SizedBox(height: 34),
            LayoutBuilder(
              builder: (context, constraints) {
                final stacked = constraints.maxWidth < 940;
                const panel = StealthSystemPanel();
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
                icon: Icons.shield_outlined,
                title: 'Private workspace',
                description:
                    'Sensitive work should feel contained, clear, and easy to review.',
                color: AppColors.blue,
              ),
            ),
            SizedBox(
              width: width,
              child: const _VisionCard(
                icon: Icons.source_outlined,
                title: 'Source visibility',
                description:
                    'Research and draft support should keep sources close to the work.',
                color: AppColors.teal,
              ),
            ),
            SizedBox(
              width: width,
              child: const _VisionCard(
                icon: Icons.hub_outlined,
                title: 'Matter context',
                description:
                    'Notes, versions, tasks, and review steps should stay connected.',
                color: AppColors.purple,
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
                      'We are sharing the idea at a high level while we build with care.',
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
