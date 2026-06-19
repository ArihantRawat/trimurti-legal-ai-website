import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/data/site_content.dart';
import '../../../shared/widgets/section_header.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});

  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  int _open = 0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedPage(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 76),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 860;
            final header = const SectionHeader(
              eyebrow: 'FAQ',
              title: 'Simple answers for interested firms.',
              description:
                  'A short overview of what we are building and how to reach us.',
            );
            final list = Column(
              children: [
                for (var i = 0; i < faqs.length; i++) ...[
                  _FaqTile(
                    question: faqs[i].question,
                    answer: faqs[i].answer,
                    open: _open == i,
                    onTap: () => setState(() => _open = _open == i ? -1 : i),
                  ),
                  if (i != faqs.length - 1) const SizedBox(height: 12),
                ],
              ],
            );

            if (stacked) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, const SizedBox(height: 28), list],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: header),
                const SizedBox(width: 42),
                Expanded(flex: 6, child: list),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FaqTile extends StatefulWidget {
  const _FaqTile({
    required this.question,
    required this.answer,
    required this.open,
    required this.onTap,
  });

  final String question;
  final String answer;
  final bool open;
  final VoidCallback onTap;

  @override
  State<_FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<_FaqTile> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      onShowFocusHighlight: (value) => setState(() => _focused = value),
      mouseCursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        expanded: widget.open,
        label: widget.question,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: Motion.duration(context, 240),
            curve: Motion.curve,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: widget.open ? 0.86 : 0.62),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _focused
                    ? AppColors.blue
                    : AppColors.deepNavy.withValues(alpha: 0.10),
                width: _focused ? 2 : 1,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.question,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    AnimatedRotation(
                      turns: widget.open ? 0.125 : 0,
                      duration: Motion.duration(context, 220),
                      curve: Motion.curve,
                      child: const Icon(Icons.add, color: AppColors.deepNavy),
                    ),
                  ],
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.answer,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                  crossFadeState: widget.open
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Motion.duration(context, 240),
                  firstCurve: Motion.curve,
                  secondCurve: Motion.curve,
                  sizeCurve: Motion.curve,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
