import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class PrincipleCarouselSection extends StatefulWidget {
  const PrincipleCarouselSection({super.key});

  @override
  State<PrincipleCarouselSection> createState() =>
      _PrincipleCarouselSectionState();
}

class _PrincipleCarouselSectionState extends State<PrincipleCarouselSection> {
  int _index = 0;

  void _next() {
    setState(() => _index = (_index + 1) % buildPrinciples.length);
  }

  void _previous() {
    setState(
      () => _index =
          (_index - 1 + buildPrinciples.length) % buildPrinciples.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = buildPrinciples[_index];

    return SectionBand(
      verticalPadding: 70,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 820;
          final header = const SectionHeader(
            eyebrow: 'How we build',
            title: 'Trust before spectacle.',
            description:
                'The product direction is guided by simple principles that matter in legal work.',
          );
          final card = _PrincipleCard(
            index: _index,
            title: item.title,
            description: item.description,
            label: item.label,
            onNext: _next,
            onPrevious: _previous,
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [header, const SizedBox(height: 26), card],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: header),
              const SizedBox(width: 44),
              Expanded(flex: 6, child: card),
            ],
          );
        },
      ),
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  const _PrincipleCard({
    required this.index,
    required this.title,
    required this.description,
    required this.label,
    required this.onNext,
    required this.onPrevious,
  });

  final int index;
  final String title;
  final String description;
  final String label;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.all(mobile ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Slide ${index + 1} of ${buildPrinciples.length}',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const Spacer(),
              _ArrowButton(icon: Icons.arrow_back, onPressed: onPrevious),
              const SizedBox(width: 8),
              _ArrowButton(icon: Icons.arrow_forward, onPressed: onNext),
            ],
          ),
          const SizedBox(height: 22),
          AnimatedSwitcher(
            duration: Motion.duration(context, 300),
            switchInCurve: Motion.curve,
            child: Column(
              key: ValueKey(label),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: AppColors.teal.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Text(
                    label,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium?.copyWith(color: AppColors.teal),
                  ),
                ),
                const SizedBox(height: 22),
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      color: AppColors.deepNavy,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.offWhite,
        fixedSize: const Size(38, 38),
      ),
    );
  }
}
