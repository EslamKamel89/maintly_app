// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/features/work_order/enums/work_order_filter_status.dart';
import 'package:maintly_app/features/work_order/models/work_order_model/work_order_model.dart';

class WorkOrdersState extends Equatable {
  final ApiStatus status;

  final List<WorkOrderModel> allWorkOrders;

  final List<WorkOrderModel> visibleWorkOrders;

  final String search;

  final WorkOrderFilterStatus selectedStatus;

  final String? errorMessage;
  const WorkOrdersState({
    required this.status,
    required this.allWorkOrders,
    required this.visibleWorkOrders,
    required this.search,
    required this.selectedStatus,
    this.errorMessage,
  });

  WorkOrdersState copyWith({
    ApiStatus? status,
    List<WorkOrderModel>? allWorkOrders,
    List<WorkOrderModel>? visibleWorkOrders,
    String? search,
    WorkOrderFilterStatus? selectedStatus,
    String? errorMessage,
  }) {
    return WorkOrdersState(
      status: status ?? this.status,
      allWorkOrders: allWorkOrders ?? this.allWorkOrders,
      visibleWorkOrders: visibleWorkOrders ?? this.visibleWorkOrders,
      search: search ?? this.search,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allWorkOrders,
    visibleWorkOrders,
    search,
    selectedStatus,
    errorMessage,
  ];
}
