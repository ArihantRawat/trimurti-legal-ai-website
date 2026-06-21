import 'package:flutter/material.dart';

import '../../../core/motion/motion.dart';
import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';

class StealthSystemPanel extends StatefulWidget {
  const StealthSystemPanel({this.compact = false, super.key});

  final bool compact;

  @override
  State<StealthSystemPanel> createState() => _StealthSystemPanelState();
}

class _StealthSystemPanelState extends State<StealthSystemPanel> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: _hovered ? 1 : 0),
        duration: Motion.duration(context, 360),
        curve: Motion.curve,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, -value * 4),
            child: child,
          );
        },
        child: Container(
          padding: EdgeInsets.all(mobile ? 14 : 18),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.deepNavy.withValues(alpha: 0.10),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepNavy.withValues(alpha: 0.13),
                blurRadius: 38,
                offset: const Offset(0, 24),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Positioned.fill(child: _PanelGrid()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _PanelHeader(),
                  SizedBox(height: widget.compact ? 14 : 18),
                  const _MatterWorkspace(),
                  SizedBox(height: widget.compact ? 12 : 16),
                  const _SourceStrip(),
                  if (!widget.compact) ...[
                    const SizedBox(height: 16),
                    const _SignalRow(),
                  ],
                ],
              ),
              Positioned(
                right: mobile ? 8 : 18,
                top: mobile ? 104 : 98,
                child: _FloatingRecommendation(compact: mobile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showStatus = constraints.maxWidth >= 300;

        return Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.deepNavy,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.balance, color: Colors.white, size: 21),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Juridical Loop OS',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Operating layer for legal work',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            if (showStatus) ...[const SizedBox(width: 8), const _LivePill()],
          ],
        );
      },
    );
  }
}

class _MatterWorkspace extends StatelessWidget {
  const _MatterWorkspace();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Matter workspace',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
              const _StatusChip(label: 'In review', color: AppColors.teal),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Acquisition financing memo',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.68),
            ),
          ),
          const SizedBox(height: 18),
          const _ProgressLine(value: 0.76),
          const SizedBox(height: 18),
          const _WorkflowRow(
            icon: Icons.edit_document,
            title: 'Draft',
            value: 'Clause cleanup ready',
            color: AppColors.blue,
          ),
          const SizedBox(height: 10),
          const _WorkflowRow(
            icon: Icons.manage_search,
            title: 'Research',
            value: '5 sources attached',
            color: AppColors.teal,
          ),
          const SizedBox(height: 10),
          const _WorkflowRow(
            icon: Icons.fact_check,
            title: 'Review',
            value: '2 open issues',
            color: AppColors.amber,
          ),
        ],
      ),
    );
  }
}

class _WorkflowRow extends StatelessWidget {
  const _WorkflowRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.075),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white.withValues(alpha: 0.66),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceStrip extends StatelessWidget {
  const _SourceStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _SourceCard(
            label: 'Source map',
            value: 'Citations grouped',
            icon: Icons.source_outlined,
            color: AppColors.teal,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _SourceCard(
            label: 'Version trail',
            value: 'Draft history clear',
            icon: Icons.history,
            color: AppColors.purple,
          ),
        ),
      ],
    );
  }
}

class _SourceCard extends StatelessWidget {
  const _SourceCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(height: 12),
          Text(label, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _FloatingRecommendation extends StatelessWidget {
  const _FloatingRecommendation({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: compact ? 142 : 172,
        padding: EdgeInsets.all(compact ? 12 : 14),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.teal.withValues(alpha: 0.16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepNavy.withValues(alpha: 0.16),
              blurRadius: 22,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: AppColors.teal, size: 16),
                const SizedBox(width: 6),
                Text(
                  compact ? 'Next' : 'Next step',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium?.copyWith(color: AppColors.teal),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              compact
                  ? 'Check sources before review.'
                  : 'Check source support before client review.',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.deepNavy,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  const _SignalRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: const [
        _PrincipleChip('Private work'),
        _PrincipleChip('Source-aware'),
        _PrincipleChip('Matter context'),
        _PrincipleChip('Lawyer review'),
      ],
    );
  }
}

class _ProgressLine extends StatelessWidget {
  const _ProgressLine({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: Motion.duration(context, 900),
      curve: Motion.curve,
      builder: (context, animated, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: animated,
            minHeight: 5,
            backgroundColor: Colors.white.withValues(alpha: 0.12),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
          ),
        );
      },
    );
  }
}

class _LivePill extends StatelessWidget {
  const _LivePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.teal.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.teal.withValues(alpha: 0.18)),
      ),
      child: Text(
        'Building',
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: AppColors.teal),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.26)),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: Colors.white),
      ),
    );
  }
}

class _PrincipleChip extends StatelessWidget {
  const _PrincipleChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.10)),
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

class _PanelGrid extends StatelessWidget {
  const _PanelGrid();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _PanelGridPainter());
  }
}

class _PanelGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.deepNavy.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    for (double x = 18; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 18; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
