import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/location.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/asset_chip.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/technician_chip.dart';

const _kCyan = Color(0xFF0891B2);
const _kViolet = Color(0xFF7C3AED);

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({
    super.key,
    required this.workOrder,
    required this.onRefresh,
  });

  final WorkOrderDetailed workOrder;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final assets = workOrder.assets ?? [];
    final technicians = workOrder.technicians ?? [];

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _LocationCard(location: workOrder.location)
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: -0.06, curve: Curves.easeOutCubic),
            const SizedBox(height: 14),
            _CollectionCard(
              icon: Icons.precision_manufacturing_outlined,
              label: 'Assets',
              color: _kCyan,
              count: assets.length,
              emptyMessage: 'No assets linked to this work order.',
              child: assets.isEmpty
                  ? null
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: assets.map((a) => AssetChip(asset: a)).toList(),
                    ),
            )
                .animate(delay: 80.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.06, curve: Curves.easeOutCubic),
            const SizedBox(height: 14),
            _CollectionCard(
              icon: Icons.engineering_outlined,
              label: 'Technicians',
              color: _kViolet,
              count: technicians.length,
              emptyMessage: 'No technicians assigned to this work order.',
              child: technicians.isEmpty
                  ? null
                  : Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: technicians.map((t) => TechnicianChip(technician: t)).toList(),
                    ),
            )
                .animate(delay: 160.ms)
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.06, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }
}

// ── Location card ──────────────────────────────────────────────────────────

class _LocationCard extends StatelessWidget {
  const _LocationCard({required this.location});

  final Location? location;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final dividerColor = Theme.of(context).dividerColor;

    final name = location?.name;
    final address = location?.address;
    final city = location?.city;
    final state = location?.state;
    final cityState = [city, state].where((e) => e != null && e.isNotEmpty).join(', ');

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: _kCyan, width: 4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _kCyan,
                          letterSpacing: .5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        name?.isNotEmpty == true ? name! : 'No location assigned',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                          color: location == null ? Colors.grey.shade400 : onSurface,
                          fontStyle: location == null ? FontStyle.italic : FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: _kCyan.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.location_on_outlined, color: _kCyan, size: 22),
                ),
              ],
            ),
          ),
          if (location != null && (address != null || cityState.isNotEmpty)) ...[
            Divider(height: 1, color: dividerColor),
            if (address != null && address.isNotEmpty)
              _DetailRow(
                icon: Icons.home_outlined,
                label: 'Address',
                value: address,
                color: _kCyan,
                isLast: cityState.isEmpty,
              ),
            if (cityState.isNotEmpty)
              _DetailRow(
                icon: Icons.location_city_outlined,
                label: 'City / State',
                value: cityState,
                color: _kCyan,
                isLast: true,
              ),
          ],
        ],
      ),
    );
  }
}

// ── Collection card ────────────────────────────────────────────────────────

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.count,
    required this.emptyMessage,
    required this.child,
  });

  final IconData icon;
  final String label;
  final Color color;
  final int count;
  final String emptyMessage;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
                    letterSpacing: .3,
                  ),
                ),
              ),
              if (count > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: color.withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    '$count',
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          Divider(height: 20, color: Theme.of(context).dividerColor),
          if (child != null)
            child!
          else
            Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 15, color: Colors.grey.shade400),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    emptyMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

// ── Detail row ─────────────────────────────────────────────────────────────

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isLast,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                        letterSpacing: .4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, indent: 74, color: Theme.of(context).dividerColor),
      ],
    );
  }
}
