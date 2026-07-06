import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/technician.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/info_row.dart';

class TechnicianCard extends StatelessWidget {
  const TechnicianCard({super.key, required this.technician, this.onTap});

  final Technician technician;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final initials = _initials(technician.name);

    return GlassCard(
          margin: const EdgeInsets.only(bottom: 18),
          onTap: onTap,
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'technician_${technician.id}',
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: primary.withOpacity(.12),
                      child: Text(
                        initials,
                        style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          technician.name?.isNotEmpty == true ? technician.name! : 'Unassigned',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(.10),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            (technician.role ?? 'Technician').toUpperCase(),
                            style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w700,
                              letterSpacing: .4,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (onTap != null) Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
                ],
              ),

              const SizedBox(height: 24),

              InfoRow(icon: Icons.email_outlined, label: 'Email', value: technician.email ?? ''),

              // InfoRow(
              //   icon: Icons.phone_outlined,
              //   label: 'Phone',
              //   value: technician.phone ?? '',
              //   showDivider: false,
              // ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 450.ms)
        .slideY(begin: .15, curve: Curves.easeOutCubic)
        .scale(begin: const Offset(.98, .98), curve: Curves.easeOutBack);
  }

  String _initials(String? name) {
    if (name == null || name.trim().isEmpty) {
      return '?';
    }

    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
