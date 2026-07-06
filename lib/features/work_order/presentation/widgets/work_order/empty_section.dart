import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EmptySection extends StatelessWidget {
  const EmptySection({
    super.key,
    required this.title,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  final String title;
  final String message;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 12),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 42, color: primary),
                )
                .animate(onPlay: (controller) => controller.repeat(reverse: true))
                .scale(
                  begin: const Offset(.96, .96),
                  end: const Offset(1.04, 1.04),
                  duration: 1800.ms,
                  curve: Curves.easeInOut,
                ),

            const SizedBox(height: 24),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).animate().fadeIn(delay: 150.ms).slideY(begin: .2),

            const SizedBox(height: 10),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, height: 1.6, color: Colors.grey.shade600),
              ),
            ).animate().fadeIn(delay: 250.ms).slideY(begin: .2),

            if (action != null) ...[
              const SizedBox(height: 24),
              action!
                  .animate()
                  .fadeIn(delay: 350.ms)
                  .scale(begin: const Offset(.9, .9), curve: Curves.easeOutBack),
            ],
          ],
        ),
      ),
    );
  }
}
