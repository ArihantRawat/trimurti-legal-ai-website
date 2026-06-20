import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';

class AnnouncementBanner extends StatelessWidget {
  const AnnouncementBanner({required this.onContact, super.key});

  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return ConstrainedPage(
      child: Padding(
        padding: EdgeInsets.only(top: mobile ? 22 : 34),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onContact,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: mobile ? 14 : 18,
                vertical: mobile ? 11 : 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.68),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: AppColors.teal.withValues(alpha: 0.18),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    color: AppColors.teal,
                    size: 17,
                  ),
                  const SizedBox(width: 9),
                  Flexible(
                    child: Text(
                      mobile
                          ? 'Building legal AI for law firms.'
                          : 'Trimurti is building Juridical Loop OS for modern law firms. Contact us to learn more.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.deepNavy,
                      ),
                    ),
                  ),
                  if (!mobile) ...[
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColors.deepNavy,
                      size: 16,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
