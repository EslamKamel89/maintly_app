import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';

const _kViolet = Color(0xFF7C3AED);

class AuditTab extends StatelessWidget {
  const AuditTab({
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
        child: _AuditCard(workOrder: workOrder)
            .animate()
            .fadeIn(duration: 400.ms)
            .slideY(begin: -0.06, curve: Curves.easeOutCubic),
      ),
    );
  }
}

class _AuditCard extends StatelessWidget {
  const _AuditCard({required this.workOrder});

  final WorkOrderDetailed workOrder;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final dividerColor = Theme.of(context).dividerColor;

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: _kViolet, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Audit',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kViolet,
                          letterSpacing: .5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Record History',
                        style: TextStyle(
                          fontSize: 20,
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
                    color: _kViolet.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.history_rounded, color: _kViolet, size: 22),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: dividerColor),
          _DateRow(
            icon: Icons.add_circle_outline_rounded,
            label: 'Created At',
            date: workOrder.createdAt,
            color: Colors.indigo,
          ),
          Divider(height: 1, indent: 74, color: dividerColor),
          _DateRow(
            icon: Icons.edit_outlined,
            label: 'Last Updated At',
            date: workOrder.updatedAt,
            color: Colors.orange,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _DateRow extends StatelessWidget {
  const _DateRow({
    required this.icon,
    required this.label,
    required this.date,
    required this.color,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final DateTime? date;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final formatted =
        date == null ? null : DateFormat('dd MMM yyyy  •  hh:mm a').format(date!);

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 14, 20, isLast ? 18 : 14),
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
                  formatted ?? 'Not set',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: formatted == null ? Colors.grey.shade400 : null,
                    fontStyle: formatted == null ? FontStyle.italic : FontStyle.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
