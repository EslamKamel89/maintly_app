import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';

class WorkOrderTimelineCard extends StatelessWidget {
  const WorkOrderTimelineCard({super.key, required this.workOrder});

  final WorkOrderDetailed workOrder;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline_rounded, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Timeline',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _TimelineTile(
            icon: Icons.add_circle_outline,
            title: 'Created',
            value: _format(workOrder.createdAt),
            color: Colors.indigo,
          ),

          _TimelineTile(
            icon: Icons.event_available_outlined,
            title: 'Scheduled',
            value: _format(workOrder.scheduledAt),
            color: Colors.orange,
          ),

          _TimelineTile(
            icon: Icons.play_circle_outline,
            title: 'Started',
            value: _format(workOrder.startedAt),
            color: Colors.blue,
          ),

          _TimelineTile(
            icon: Icons.flag_outlined,
            title: 'Due',
            value: _format(workOrder.dueAt),
            color: Colors.deepOrange,
          ),

          _TimelineTile(
            icon: Icons.check_circle_outline,
            title: 'Completed',
            value: _format(workOrder.completedAt),
            color: Colors.green,
            isLast: true,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: .15);
  }

  static String _format(DateTime? value) {
    if (value == null) {
      return '—';
    }

    return DateFormat('dd MMM yyyy • hh:mm a').format(value);
  }
}

class _TimelineTile extends StatelessWidget {
  const _TimelineTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: color.withOpacity(.12), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 20),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
