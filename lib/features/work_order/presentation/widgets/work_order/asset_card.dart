import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/asset.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/info_row.dart';

class AssetCard extends StatelessWidget {
  const AssetCard({super.key, required this.asset, this.onTap});

  final Asset asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return GlassCard(
          margin: const EdgeInsets.only(bottom: 18),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: primary.withOpacity(.10),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(Icons.precision_manufacturing_rounded, color: primary, size: 28),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          asset.name?.isNotEmpty == true ? asset.name! : 'Unnamed Asset',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),

                        if ((asset.assetCode ?? '').isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: primary.withOpacity(.08),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              asset.assetCode!,
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: .4,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  if (onTap != null) Icon(Icons.chevron_right_rounded, color: Colors.grey.shade500),
                ],
              ),

              const SizedBox(height: 24),

              InfoRow(
                icon: Icons.factory_outlined,
                label: 'Manufacturer',
                value: asset.manufacturer ?? '',
              ),

              InfoRow(icon: Icons.category_outlined, label: 'Model', value: asset.model ?? ''),

              InfoRow(
                icon: Icons.qr_code_rounded,
                label: 'Serial Number',
                value: asset.serialNumber ?? '',
                showDivider: false,
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 450.ms)
        .slideY(begin: .15, curve: Curves.easeOutCubic)
        .scale(begin: const Offset(.98, .98), curve: Curves.easeOutBack);
  }
}
