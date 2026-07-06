import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';

class WorkOrderDescriptionCard extends StatelessWidget {
  const WorkOrderDescriptionCard({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description_outlined, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Description',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          SelectableText(
            description.trim().isEmpty
                ? 'No description was provided for this work order.'
                : description,
            style: TextStyle(fontSize: 16, height: 1.8, color: Colors.grey.shade800),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 450.ms).slideY(begin: .15, curve: Curves.easeOutCubic);
  }
}
