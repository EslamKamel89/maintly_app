import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_state.dart';
import 'package:maintly_app/features/work_order/services/work_orders_service.dart';

class WorkOrderCubit extends Cubit<WorkOrderState> {
  WorkOrderCubit()
    : _service = serviceLocator<WorkOrdersService>(),
      super(const WorkOrderState(status: ApiStatus.initial, workOrder: null));

  final WorkOrdersService _service;

  Future<void> load(int workOrderId) async {
    emit(state.copyWith(status: ApiStatus.loading, errorMessage: null));

    final result = await _service.getWorkOrder(workOrderId);

    if (result.response != ResponseEnum.success || result.data == null) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: result.errorMessage));

      return;
    }

    emit(state.copyWith(status: ApiStatus.loaded, workOrder: result.data));
  }

  Future<void> refresh(int workOrderId) async {
    emit(state.copyWith(status: ApiStatus.refreshing));

    final result = await _service.getWorkOrder(workOrderId);

    if (result.response != ResponseEnum.success || result.data == null) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: result.errorMessage));

      return;
    }

    emit(state.copyWith(status: ApiStatus.loaded, workOrder: result.data));
  }
}
