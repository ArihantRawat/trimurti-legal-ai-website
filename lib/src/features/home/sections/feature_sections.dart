import 'package:flutter/material.dart';

import '../../../shared/data/site_content.dart';
import '../../../shared/models/site_models.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class WhatWeDoSection extends StatelessWidget {
  const WhatWeDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeatureSection(
      eyebrow: 'What we do',
      title: 'A clearer way to work on legal matters.',
      description:
          'Trimurti is focused on the work lawyers do every day: drafting, research, review, and matter organization.',
      items: whatWeDo,
    );
  }
}

class WhyTrimurtiSection extends StatelessWidget {
  const WhyTrimurtiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const _FeatureSection(
      eyebrow: 'Why Trimurti',
      title: 'Software for a profession where trust matters.',
      description:
          'We are designing the product to feel calm, clear, and useful for real legal teams.',
      items: whyTrimurti,
      tinted: true,
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.items,
    this.tinted = false,
  });

  final String eyebrow;
  final String title;
  final String description;
  final List<FeatureItem> items;
  final bool tinted;

  @override
  Widget build(BuildContext context) {
    return SectionBand(
      tinted: tinted,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            eyebrow: eyebrow,
            title: title,
            description: description,
          ),
          const SizedBox(height: 34),
          FeatureGrid(items: items),
        ],
      ),
    );
  }
}
