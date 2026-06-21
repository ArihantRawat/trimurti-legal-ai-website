import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/models/site_models.dart';
import '../../../shared/widgets/premium_button.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/feature_grid.dart';

class UseCaseRailSection extends StatefulWidget {
  const UseCaseRailSection({required this.onContact, super.key});

  final VoidCallback onContact;

  @override
  State<UseCaseRailSection> createState() => _UseCaseRailSectionState();
}

class _UseCaseRailSectionState extends State<UseCaseRailSection> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final selected = useCases[_selected];

    return SectionBand(
      tinted: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final stacked = constraints.maxWidth < 880;

          final header = SectionHeader(
            eyebrow: 'Product direction',
            title: 'The work we are focused on first.',
            description:
                'A tighter path from drafting and research to matter context and lawyer review.',
          );
          final rail = _UseCaseRail(
            selectedIndex: _selected,
            onSelected: (index) => setState(() => _selected = index),
          );
          final panel = _UseCasePanel(
            item: selected,
            onContact: widget.onContact,
          );

          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(height: 28),
                rail,
                const SizedBox(height: 18),
                panel,
              ],
            );
          }

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [header, const SizedBox(height: 30), rail],
                ),
              ),
              const SizedBox(width: 42),
              Expanded(flex: 6, child: panel),
            ],
          );
        },
      ),
    );
  }
}

class _UseCaseRail extends StatelessWidget {
  const _UseCaseRail({required this.selectedIndex, required this.onSelected});

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (var i = 0; i < useCases.length; i++)
          _UseCasePill(
            item: useCases[i],
            selected: selectedIndex == i,
            wide: mobile,
            onTap: () => onSelected(i),
          ),
      ],
    );
  }
}

class _UseCasePill extends StatelessWidget {
  const _UseCasePill({
    required this.item,
    required this.selected,
    required this.wide,
    required this.onTap,
  });

  final UseCaseItem item;
  final bool selected;
  final bool wide;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wide ? double.infinity : null,
      child: AnimatedContainer(
        duration: Motion.duration(context, 220),
        curve: Motion.curve,
        decoration: BoxDecoration(
          color: selected
              ? AppColors.deepNavy
              : Colors.white.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected
                ? AppColors.deepNavy
                : AppColors.deepNavy.withValues(alpha: 0.10),
          ),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: AppColors.deepNavy.withValues(alpha: 0.14),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisSize: wide ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  Icon(
                    item.icon,
                    color: selected ? Colors.white : item.color,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: selected ? Colors.white : AppColors.deepNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UseCasePanel extends StatelessWidget {
  const _UseCasePanel({required this.item, required this.onContact});

  final UseCaseItem item;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Motion.duration(context, 340),
      switchInCurve: Motion.curve,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.04, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(item.title),
        width: double.infinity,
        padding: const EdgeInsets.all(30),
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
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 26),
            Text(
              item.title,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              item.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.76),
              ),
            ),
            const SizedBox(height: 22),
            _UseCaseSignals(item: item),
            const SizedBox(height: 28),
            PremiumButton(
              label: 'Contact us',
              icon: Icons.arrow_forward,
              secondary: true,
              onPressed: onContact,
            ),
          ],
        ),
      ),
    );
  }
}

class _UseCaseSignals extends StatelessWidget {
  const _UseCaseSignals({required this.item});

  final UseCaseItem item;

  @override
  Widget build(BuildContext context) {
    final signals = switch (item.title) {
      'Draft' => ['Matter facts', 'Clause history', 'Review notes'],
      'Research' => ['Relevant sources', 'Citation path', 'Memo outline'],
      'Organize' => ['Tasks', 'Versions', 'Communications'],
      _ => ['Open issues', 'Source checks', 'Next steps'],
    };

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final signal in signals)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Text(
              signal,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.82),
              ),
            ),
          ),
      ],
    );
  }
}
