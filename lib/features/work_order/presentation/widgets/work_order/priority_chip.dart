import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PriorityChip extends StatelessWidget {
  const PriorityChip({super.key, required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) {
    final style = _style(priority);

    return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [style.color.withOpacity(.18), style.color.withOpacity(.08)],
            ),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: style.color.withOpacity(.30)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(style.icon, size: 16, color: style.color),

              const SizedBox(width: 8),

              Text(
                style.label,
                style: TextStyle(color: style.color, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 350.ms)
        .scale(begin: const Offset(.85, .85), curve: Curves.easeOutBack);
  }

  _PriorityStyle _style(String value) {
    switch (value.toLowerCase()) {
      case 'low':
        return const _PriorityStyle(
          label: 'Low',
          color: Colors.grey,
          icon: Icons.keyboard_double_arrow_down_rounded,
        );

      case 'medium':
        return const _PriorityStyle(
          label: 'Medium',
          color: Colors.blue,
          icon: Icons.remove_rounded,
        );

      case 'high':
        return const _PriorityStyle(
          label: 'High',
          color: Colors.orange,
          icon: Icons.keyboard_double_arrow_up_rounded,
        );

      case 'critical':
        return const _PriorityStyle(
          label: 'Critical',
          color: Colors.red,
          icon: Icons.priority_high_rounded,
        );

      default:
        return const _PriorityStyle(
          label: 'Unknown',
          color: Colors.grey,
          icon: Icons.help_outline_rounded,
        );
    }
  }
}

class _PriorityStyle {
  const _PriorityStyle({required this.label, required this.color, required this.icon});

  final String label;
  final Color color;
  final IconData icon;
}
