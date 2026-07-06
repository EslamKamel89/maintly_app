import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/core/enums/response_type.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/work_order/enums/work_order_filter_status.dart';
import 'package:maintly_app/features/work_order/models/work_order_model/work_order_model.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_orders/work_orders_state.dart';
import 'package:maintly_app/features/work_order/services/work_orders_service.dart';

class WorkOrdersCubit extends Cubit<WorkOrdersState> {
  WorkOrdersCubit()
    : _service = serviceLocator<WorkOrdersService>(),
      super(
        const WorkOrdersState(
          status: ApiStatus.initial,
          allWorkOrders: [],
          visibleWorkOrders: [],
          search: '',
          selectedStatus: WorkOrderFilterStatus.all,
        ),
      );
  final WorkOrdersService _service;
  Future<void> load() async {
    emit(state.copyWith(status: ApiStatus.loading, errorMessage: null));
    final result = await _service.getWorkOrders();
    if (result.response != ResponseEnum.success || result.data == null) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: result.errorMessage));
      return;
    }
    final workOrders = result.data!;

    emit(
      state.copyWith(
        status: workOrders.isEmpty ? ApiStatus.empty : ApiStatus.loaded,
        allWorkOrders: workOrders,
      ),
    );
    _applyFilters();
  }

  Future<void> refresh() async {
    emit(state.copyWith(status: ApiStatus.refreshing));
    final result = await _service.getWorkOrders();
    if (result.response != ResponseEnum.success || result.data == null) {
      emit(state.copyWith(status: ApiStatus.error, errorMessage: result.errorMessage));
      return;
    }
    emit(
      state.copyWith(
        status: result.data!.isEmpty ? ApiStatus.empty : ApiStatus.loaded,
        allWorkOrders: result.data!,
      ),
    );

    _applyFilters();
  }

  void search(String value) {
    emit(state.copyWith(search: value));

    _applyFilters();
  }

  void changeStatus(WorkOrderFilterStatus status) {
    emit(state.copyWith(selectedStatus: status));

    _applyFilters();
  }

  void clearSearch() {
    emit(state.copyWith(search: ''));

    _applyFilters();
  }

  void clearFilters() {
    emit(state.copyWith(search: '', selectedStatus: WorkOrderFilterStatus.all));

    _applyFilters();
  }

  void _applyFilters() {
    Iterable<WorkOrderModel> filtered = state.allWorkOrders;

    if (state.selectedStatus != WorkOrderFilterStatus.all) {
      filtered = filtered.where((e) => e.status == state.selectedStatus.value);
    }
    final search = state.search.trim().toLowerCase();
    if (search.isNotEmpty) {
      filtered = filtered.where((workOrder) {
        return (workOrder.title ?? '').toLowerCase().contains(search) ||
            (workOrder.description ?? '').toLowerCase().contains(search) ||
            (workOrder.customer?.companyName ?? '').toLowerCase().contains(search) ||
            (workOrder.location?.name ?? '').toLowerCase().contains(search);
      });
    }
    final visible = filtered.toList();
    final ApiStatus status;

    if (state.allWorkOrders.isEmpty) {
      status = ApiStatus.empty;
    } else if (state.status == ApiStatus.refreshing) {
      status = ApiStatus.refreshing;
    } else {
      status = ApiStatus.loaded;
    }

    emit(state.copyWith(visibleWorkOrders: visible, status: status));
  }
}
