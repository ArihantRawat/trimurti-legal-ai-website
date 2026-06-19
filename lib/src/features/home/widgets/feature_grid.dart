import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../shared/models/site_models.dart';
import '../../../shared/widgets/feature_card.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({required this.items, this.compact = false, super.key});

  final List<FeatureItem> items;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 980
            ? 3
            : constraints.maxWidth > 640
            ? 2
            : 1;
        final spacing = compact ? 12.0 : 16.0;
        final width =
            (constraints.maxWidth - (columns - 1) * spacing) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: FeatureCard(item: item),
              ),
          ],
        );
      },
    );
  }
}

class SectionBand extends StatelessWidget {
  const SectionBand({
    required this.child,
    this.tinted = false,
    this.verticalPadding = 76,
    super.key,
  });

  final Widget child;
  final bool tinted;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedPage(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: child,
      ),
    );

    return SizedBox(
      width: double.infinity,
      child: tinted
          ? ColoredBox(
              color: Colors.white.withValues(alpha: 0.26),
              child: content,
            )
          : content,
    );
  }
}
