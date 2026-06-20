import 'package:flutter/material.dart';

import '../../core/responsive/breakpoints.dart';
import '../../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.eyebrow,
    required this.title,
    required this.description,
    this.centered = false,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String description;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return Column(
      crossAxisAlignment: centered
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow.toUpperCase(),
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: AppColors.teal,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style:
              (mobile
                      ? Theme.of(context).textTheme.headlineLarge
                      : Theme.of(context).textTheme.displayMedium)
                  ?.copyWith(fontSize: mobile ? 30 : null),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            description,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}
