import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final style = _style(status, primary);

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

  _StatusStyle _style(String value, Color primary) {
    switch (value.toLowerCase()) {
      case 'draft':
        return const _StatusStyle(
          label: 'Draft',
          color: Colors.grey,
          icon: Icons.edit_note_rounded,
        );
      case 'open':
        return const _StatusStyle(
          label: 'Open',
          color: Colors.blue,
          icon: Icons.lock_open_rounded,
        );
      case 'assigned':
        return const _StatusStyle(
          label: 'Assigned',
          color: Colors.orange,
          icon: Icons.assignment_ind_rounded,
        );
      case 'in_progress':
        return _StatusStyle(
          label: 'In Progress',
          color: primary,
          icon: Icons.build_circle_outlined,
        );
      case 'completed':
        return const _StatusStyle(
          label: 'Completed',
          color: Colors.green,
          icon: Icons.check_circle_outline_rounded,
        );
      case 'cancelled':
        return const _StatusStyle(
          label: 'Cancelled',
          color: Colors.red,
          icon: Icons.cancel_outlined,
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
