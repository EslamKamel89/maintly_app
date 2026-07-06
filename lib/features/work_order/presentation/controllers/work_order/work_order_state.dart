// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/features/work_order/models/work_order_detailed/work_order_detailed.dart';

class WorkOrderState extends Equatable {
  final ApiStatus status;

  final WorkOrderDetailed? workOrder;

  final String? errorMessage;

  const WorkOrderState({required this.status, required this.workOrder, this.errorMessage});

  WorkOrderState copyWith({ApiStatus? status, WorkOrderDetailed? workOrder, String? errorMessage}) {
    return WorkOrderState(
      status: status ?? this.status,
      workOrder: workOrder ?? this.workOrder,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, workOrder, errorMessage];
}
