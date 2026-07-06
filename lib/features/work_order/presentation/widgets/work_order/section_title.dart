import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
    this.trailing,
    this.bottomPadding = 18,
  });

  final String title;
  final IconData icon;
  final Widget? trailing;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),

          if (trailing != null) trailing!,
        ],
      ).animate().fadeIn(duration: 350.ms).slideX(begin: -.15, curve: Curves.easeOutCubic),
    );
  }
}
