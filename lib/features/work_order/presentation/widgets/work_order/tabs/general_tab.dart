import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/priority_chip.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/status_chip.dart';

class GeneralTab extends StatelessWidget {
  const GeneralTab({
    super.key,
    required this.workOrder,
    required this.onRefresh,
  });

  final WorkOrderDetailed workOrder;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(workOrder: workOrder)
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.06, curve: Curves.easeOutCubic),
            const SizedBox(height: 14),
            _DetailsCard(workOrder: workOrder)
                .animate(delay: 80.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.06, curve: Curves.easeOutCubic),
            const SizedBox(height: 14),
            _DescriptionCard(description: workOrder.description)
                .animate(delay: 160.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.06, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }
}

// ── Hero card ──────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.workOrder});

  final WorkOrderDetailed workOrder;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final hasChips = workOrder.status != null || workOrder.priority != null;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Accent strip + header row
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(color: primary, width: 4),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workOrder.id != null ? 'Work Order #${workOrder.id}' : 'Work Order',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: primary,
                          letterSpacing: .5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        (workOrder.title ?? '').isEmpty ? 'Untitled Work Order' : workOrder.title!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.assignment_outlined, color: primary, size: 22),
                ),
              ],
            ),
          ),

          if (hasChips) ...[
            Divider(height: 1, color: Theme.of(context).dividerColor),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: [
                  if (workOrder.status != null) StatusChip(status: workOrder.status!),
                  if (workOrder.priority != null) PriorityChip(priority: workOrder.priority!),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ── Details card ───────────────────────────────────────────────────────────

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.workOrder});

  final WorkOrderDetailed workOrder;

  @override
  Widget build(BuildContext context) {
    final customer = workOrder.customer;
    final creator = workOrder.creator;

    if (customer == null && creator == null) return const SizedBox.shrink();

    final rows = <_DetailRow>[];

    if (customer != null) {
      rows.add(_DetailRow(
        icon: Icons.domain_rounded,
        label: 'Customer',
        value: customer.companyName ?? '—',
        color: const Color(0xFF0891B2),
        isLast: creator == null,
      ));
    }

    if (creator != null) {
      rows.add(_DetailRow(
        icon: Icons.person_outline_rounded,
        label: 'Created By',
        value: creator.name ?? '—',
        color: const Color(0xFF7C3AED),
        isLast: true,
      ));
    }

    return GlassCard(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(children: rows),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isLast,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                        letterSpacing: .4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, indent: 74, color: Theme.of(context).dividerColor),
      ],
    );
  }
}

// ── Description card ───────────────────────────────────────────────────────

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard({required this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final isEmpty = (description ?? '').trim().isEmpty;
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_outlined, color: primary, size: 18),
              const SizedBox(width: 10),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: primary,
                  letterSpacing: .3,
                ),
              ),
            ],
          ),
          Divider(height: 24, color: Theme.of(context).dividerColor),
          SelectableText(
            isEmpty ? 'No description provided for this work order.' : description!,
            style: TextStyle(
              fontSize: 15,
              height: 1.75,
              color: isEmpty ? Colors.grey.shade500 : onSurface.withValues(alpha: 0.85),
              fontStyle: isEmpty ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}
