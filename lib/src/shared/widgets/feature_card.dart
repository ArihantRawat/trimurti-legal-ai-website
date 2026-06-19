import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../models/site_models.dart';
import 'hover_lift_card.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({required this.item, super.key});

  final FeatureItem item;

  @override
  Widget build(BuildContext context) {
    return HoverLiftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: item.color.withValues(alpha: 0.18)),
            ),
            child: Icon(item.icon, color: item.color, size: 22),
          ),
          const SizedBox(height: 22),
          Text(item.title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text(item.description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 18),
          Container(
            height: 2,
            width: 64,
            decoration: BoxDecoration(
              color: AppColors.deepNavy.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ],
      ),
    );
  }
}
