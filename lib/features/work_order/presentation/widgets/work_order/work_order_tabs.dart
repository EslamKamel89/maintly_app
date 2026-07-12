import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/attachments_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/audit_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/comments_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/general_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/resources_tab.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/tabs/scheduling_tab.dart';

const _kTabColors = [
  Color(0xFF4F46E5), // General   – indigo
  Color(0xFF0891B2), // Resources – cyan
  Color(0xFFEA580C), // Scheduling– orange
  Color(0xFF7C3AED), // Audit     – violet
  Color(0xFFDB2777), // Attachments – pink
  Color(0xFF16A34A), // Comments  – green
];

const _kTabLabels = [
  'General',
  'Resources',
  'Scheduling',
  'Audit',
  'Attachments',
  'Comments',
];

const _kTabIcons = [
  Icons.info_outline_rounded,
  Icons.build_outlined,
  Icons.calendar_month_outlined,
  Icons.history_rounded,
  Icons.attach_file_rounded,
  Icons.chat_bubble_outline_rounded,
];

class WorkOrderTabs extends StatelessWidget {
  const WorkOrderTabs({
    super.key,
    required this.workOrder,
    required this.isRefreshing,
    required this.onRefresh,
  });

  final WorkOrderDetailed workOrder;
  final bool isRefreshing;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _kTabLabels.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            workOrder.title ?? 'Work Order',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(isRefreshing ? 60.0 : 56.0),
            child: _ColoredTabBar(isRefreshing: isRefreshing),
          ),
        ),
        body: TabBarView(
          children: [
            GeneralTab(workOrder: workOrder, onRefresh: onRefresh),
            ResourcesTab(workOrder: workOrder, onRefresh: onRefresh),
            SchedulingTab(workOrder: workOrder, onRefresh: onRefresh),
            AuditTab(workOrder: workOrder, onRefresh: onRefresh),
            AttachmentsTab(workOrder: workOrder, onRefresh: onRefresh),
            CommentsTab(workOrder: workOrder, onRefresh: onRefresh),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _ColoredTabBar extends StatelessWidget {
  const _ColoredTabBar({required this.isRefreshing});

  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);

    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        final selected = controller.index;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isRefreshing) const LinearProgressIndicator(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              child: Row(
                children: List.generate(_kTabLabels.length, (i) {
                  final isSelected = i == selected;
                  final color = _kTabColors[i];

                  return Padding(
                    padding: EdgeInsets.only(right: i < _kTabLabels.length - 1 ? 8 : 0),
                    child: GestureDetector(
                      onTap: () => controller.animateTo(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected ? color : color.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: isSelected ? color : color.withValues(alpha: 0.50),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _kTabIcons[i],
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _kTabLabels[i],
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
