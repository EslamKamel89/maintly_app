import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/attachment_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/empty_section.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/glass_card.dart';

const _kPink = Color(0xFFDB2777);

class AttachmentsTab extends StatelessWidget {
  const AttachmentsTab({
    super.key,
    required this.workOrder,
    required this.onRefresh,
  });

  final WorkOrderDetailed workOrder;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final attachments = workOrder.attachments ?? [];

    if (attachments.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
          child: Column(
            children: [
              _AttachmentsHeader(count: 0)
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.06, curve: Curves.easeOutCubic),
              const SizedBox(height: 14),
              const EmptySection(
                title: 'No Attachments',
                message: 'No files have been attached to this work order.',
                icon: Icons.attach_file_rounded,
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            sliver: SliverToBoxAdapter(
              child: _AttachmentsHeader(count: attachments.length)
                  .animate()
                  .fadeIn(duration: 400.ms)
                  .slideY(begin: -0.06, curve: Curves.easeOutCubic),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 32),
            sliver: SliverList.builder(
              itemCount: attachments.length,
              itemBuilder: (context, index) => AttachmentCard(
                attachment: attachments[index],
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentsHeader extends StatelessWidget {
  const _AttachmentsHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final countLabel = count == 0
        ? 'No files'
        : count == 1
            ? '1 file'
            : '$count files';

    return GlassCard(
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: _kPink, width: 4)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attachments',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _kPink,
                      letterSpacing: .5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    countLabel,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: count == 0 ? Colors.grey.shade400 : onSurface,
                      fontStyle: count == 0 ? FontStyle.italic : FontStyle.normal,
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
                color: _kPink.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.attach_file_rounded, color: _kPink, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}
