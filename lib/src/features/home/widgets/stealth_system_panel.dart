import 'package:flutter/material.dart';

import '../../../core/responsive/breakpoints.dart';
import '../../../core/theme/app_theme.dart';

class StealthSystemPanel extends StatelessWidget {
  const StealthSystemPanel({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final nodes = [
      _SystemNode('Drafting', Icons.edit_document, AppColors.blue),
      _SystemNode('Research', Icons.travel_explore, AppColors.teal),
      _SystemNode('Matter Work', Icons.account_tree, AppColors.purple),
      _SystemNode('Review', Icons.fact_check, AppColors.amber),
    ];

    return Container(
      padding: EdgeInsets.all(mobile ? 18 : 24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.deepNavy.withValues(alpha: 0.10)),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepNavy.withValues(alpha: 0.12),
            blurRadius: 34,
            offset: const Offset(0, 22),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'A legal AI workspace in progress',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: compact ? 18 : 26),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(mobile ? 16 : 20),
            decoration: BoxDecoration(
              color: AppColors.deepNavy,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Built around legal work',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'We are connecting drafting, research, matter context, and review into one focused system for law firms.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.76),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: compact ? 16 : 22),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              for (final node in nodes)
                _NodeChip(node: node, wide: mobile || compact),
            ],
          ),
          if (!compact) ...[
            const SizedBox(height: 22),
            Divider(color: AppColors.deepNavy.withValues(alpha: 0.10)),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: const [
                _PrincipleChip('Privacy first'),
                _PrincipleChip('Clear sources'),
                _PrincipleChip('Lawyer review'),
                _PrincipleChip('Firm context'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _SystemNode {
  const _SystemNode(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}

class _NodeChip extends StatelessWidget {
  const _NodeChip({required this.node, required this.wide});

  final _SystemNode node;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: wide ? double.infinity : 142,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: node.color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: node.color.withValues(alpha: 0.16)),
        ),
        child: Row(
          mainAxisSize: wide ? MainAxisSize.max : MainAxisSize.min,
          children: [
            Icon(node.icon, color: node.color, size: 18),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                node.label,
                style: Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: AppColors.deepNavy),
              ),
            ),
          ],
        ),
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
