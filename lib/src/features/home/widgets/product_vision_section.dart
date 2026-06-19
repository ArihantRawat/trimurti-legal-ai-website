import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/widgets/feature_card.dart';
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
                  'A private legal AI workspace for drafting, research, matter context, and review.',
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
            for (final item in whatWeDo)
              SizedBox(
                width: width,
                child: FeatureCard(item: item),
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
