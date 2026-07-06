import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final style = _style(status);

    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: style.color.withOpacity(.12),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: style.color.withOpacity(.25)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(style.icon, size: 16, color: style.color),

              const SizedBox(width: 8),

              Text(
                style.label,
                style: TextStyle(
                  color: style.color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .3,
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(.9, .9), curve: Curves.easeOutBack);
  }

  _StatusStyle _style(String value) {
    switch (value.toLowerCase()) {
      case 'assigned':
        return const _StatusStyle(
          label: 'Assigned',
          color: Colors.orange,
          icon: Icons.assignment_ind_rounded,
        );

      case 'in_progress':
        return const _StatusStyle(
          label: 'In Progress',
          color: Colors.blue,
          icon: Icons.build_circle_outlined,
        );

      case 'completed':
        return const _StatusStyle(
          label: 'Completed',
          color: Colors.green,
          icon: Icons.check_circle_outline_rounded,
        );

      default:
        return const _StatusStyle(
          label: 'Unknown',
          color: Colors.grey,
          icon: Icons.help_outline_rounded,
        );
    }
  }
}

class _StatusStyle {
  const _StatusStyle({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;
}
