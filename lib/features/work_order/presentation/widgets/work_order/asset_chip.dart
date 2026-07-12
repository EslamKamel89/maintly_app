import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/asset.dart';

class AssetChip extends StatelessWidget {
  const AssetChip({super.key, required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final name = asset.name?.isNotEmpty == true ? asset.name! : 'Unnamed';
    final code = asset.assetCode;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: primary.withOpacity(.08),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: primary.withOpacity(.20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.precision_manufacturing_rounded, size: 15, color: primary),
          const SizedBox(width: 6),
          Text(
            code != null && code.isNotEmpty ? '$name · $code' : name,
            style: TextStyle(
              color: primary,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
