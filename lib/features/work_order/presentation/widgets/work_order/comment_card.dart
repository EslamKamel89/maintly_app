import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/comment.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.comment, this.index = 0});

  final Comment comment;
  final int index;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final name = comment.user?.name ?? 'Unknown';
    final initials = _initials(comment.user?.name);
    final date = comment.createdAt;
    final dateStr = date == null ? '' : DateFormat('dd MMM yyyy · hh:mm a').format(date);

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: primary.withOpacity(.14),
            child: Text(
              initials,
              style: TextStyle(
                color: primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (dateStr.isNotEmpty)
                      Text(
                        dateStr,
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  comment.comment ?? '',
                  style: TextStyle(fontSize: 14, height: 1.55, color: Colors.grey.shade800),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: (index * 60).ms)
        .fadeIn(duration: 350.ms)
        .slideX(begin: .08, curve: Curves.easeOutCubic);
  }

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) return '?';
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
