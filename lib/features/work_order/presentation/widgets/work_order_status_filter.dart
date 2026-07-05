import 'package:flutter/material.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/features/work_order/enums/work_order_filter_status.dart';

class WorkOrderStatusFilter extends StatelessWidget {
  const WorkOrderStatusFilter({super.key, required this.selected, required this.onChanged});

  final WorkOrderFilterStatus selected;
  final ValueChanged<WorkOrderFilterStatus> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: WorkOrderFilterStatus.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final status = WorkOrderFilterStatus.values[index];
          final selectedItem = status == selected;

          return ChoiceChip(
            label: Text(_label(status)),
            selected: selectedItem,
            onSelected: (_) => onChanged(status),
            selectedColor: context.primaryColor,
            labelStyle: TextStyle(
              color: selectedItem ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }

  String _label(WorkOrderFilterStatus status) {
    switch (status) {
      case WorkOrderFilterStatus.all:
        return 'All';
      case WorkOrderFilterStatus.assigned:
        return 'Assigned';
      case WorkOrderFilterStatus.inProgress:
        return 'In Progress';
      case WorkOrderFilterStatus.completed:
        return 'Completed';
    }
  }
}
