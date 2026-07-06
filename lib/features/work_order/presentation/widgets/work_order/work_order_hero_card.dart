import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/priority_chip.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/status_chip.dart';

class WorkOrderHeroCard extends StatelessWidget {
  const WorkOrderHeroCard({super.key, required this.workOrder});

  final WorkOrderDetailed workOrder;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GlassCard(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  StatusChip(status: workOrder.status ?? ''),
                  PriorityChip(priority: workOrder.priority ?? ''),
                ],
              ),

              const SizedBox(height: 22),

              Text(
                workOrder.title ?? 'Untitled Work Order',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1.15),
              ),

              const SizedBox(height: 16),

              Text(
                (workOrder.description ?? '').trim().isEmpty
                    ? 'No description has been provided for this work order.'
                    : workOrder.description!,
                style: TextStyle(fontSize: 16, height: 1.7, color: Colors.grey.shade700),
              ),

              const SizedBox(height: 26),

              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.calendar_today_rounded,
                      title: 'Scheduled',
                      value: _format(workOrder.scheduledAt),
                      color: primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _MetricCard(
                      icon: Icons.event_available_rounded,
                      title: 'Due',
                      value: _format(workOrder.dueAt),
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.location_on_outlined,
                      title: 'Location',
                      value: workOrder.location?.name ?? '-',
                      color: Colors.teal,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: _MetricCard(
                      icon: Icons.business_outlined,
                      title: 'Customer',
                      value: workOrder.customer?.companyName ?? '-',
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: -.08)
        .scale(begin: const Offset(.98, .98), curve: Curves.easeOutBack);
  }

  static String _format(DateTime? date) {
    if (date == null) {
      return '-';
    }

    return DateFormat('dd MMM yyyy').format(date);
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),

          const SizedBox(height: 14),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            value.isEmpty ? '-' : value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3),
          ),
        ],
      ),
    );
  }
}
