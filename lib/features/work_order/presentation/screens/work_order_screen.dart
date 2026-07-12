import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_cubit.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_state.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/work_order_tabs.dart';

class WorkOrderScreen extends StatelessWidget {
  const WorkOrderScreen({super.key, required this.workOrderId});

  final int workOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WorkOrderCubit()..load(workOrderId),
      child: _WorkOrderView(workOrderId: workOrderId),
    );
  }
}

class _WorkOrderView extends StatelessWidget {
  const _WorkOrderView({required this.workOrderId});

  final int workOrderId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkOrderCubit, WorkOrderState>(
      builder: (context, state) {
        final cubit = context.read<WorkOrderCubit>();

        return switch (state.status) {
          ApiStatus.initial || ApiStatus.loading => Scaffold(
            appBar: AppBar(title: const Text('Work Order'), centerTitle: false),
            body: const _LoadingView(),
          ),

          ApiStatus.error when state.workOrder == null => Scaffold(
            appBar: AppBar(title: const Text('Work Order'), centerTitle: false),
            body: _ErrorView(message: state.errorMessage, onRetry: () => cubit.load(workOrderId)),
          ),

          _ =>
            state.workOrder != null
                ? WorkOrderTabs(
                    workOrder: state.workOrder!,
                    isRefreshing: state.status == ApiStatus.refreshing,
                    onRefresh: () => cubit.refresh(workOrderId),
                  )
                : Scaffold(
                    appBar: AppBar(title: const Text('Work Order'), centerTitle: false),
                    body: const _LoadingView(),
                  ),
        };
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline_rounded, size: 70, color: Colors.red.shade400),

            const SizedBox(height: 20),

            const Text(
              'Unable to load work order',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              message ?? 'Something went wrong.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade700, height: 1.5),
            ),

            const SizedBox(height: 28),

            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
