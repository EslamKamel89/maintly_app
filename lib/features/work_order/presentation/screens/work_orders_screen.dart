import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/auth/models/response/user.dart';
import 'package:maintly_app/features/auth/services/auth_service.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order_cubit.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order_state.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/user_header_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order_search_bar.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order_status_filter.dart';

class WorkOrderScreen extends StatelessWidget {
  const WorkOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator<AuthService>().getCachedUser();

    if (user == null) {
      return const Scaffold(body: Center(child: Text('No cached user found.')));
    }

    return BlocProvider(
      create: (_) => WorkOrderCubit()..load(),
      child: _WorkOrderView(user: user),
    );
  }
}

class _WorkOrderView extends StatefulWidget {
  const _WorkOrderView({required this.user});

  final User user;

  @override
  State<_WorkOrderView> createState() => _WorkOrderViewState();
}

class _WorkOrderViewState extends State<_WorkOrderView> {
  final TextEditingController _searchController = TextEditingController();

  WorkOrderCubit get cubit => context.read<WorkOrderCubit>();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() {
    return cubit.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Work Orders'), centerTitle: false),
      body: BlocBuilder<WorkOrderCubit, WorkOrderState>(
        builder: (context, state) {
          if (state.status == ApiStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == ApiStatus.error && state.visibleWorkOrders.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 64),
                    const SizedBox(height: 20),
                    Text(
                      state.errorMessage ?? 'Something went wrong.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(onPressed: cubit.load, child: const Text('Retry')),
                  ],
                ),
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                UserHeaderCard(user: widget.user).animate().fadeIn().slideY(begin: -.15),

                const SizedBox(height: 24),

                WorkOrderSearchBar(
                  controller: _searchController,
                  onChanged: cubit.search,
                ).animate().fadeIn(delay: 150.ms).slideY(begin: .15),

                const SizedBox(height: 18),

                WorkOrderStatusFilter(
                  selected: state.selectedStatus,
                  onChanged: cubit.changeStatus,
                ).animate().fadeIn(delay: 250.ms),

                const SizedBox(height: 24),

                if (state.status == ApiStatus.refreshing)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: LinearProgressIndicator(),
                  ),

                if (state.visibleWorkOrders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Icon(Icons.assignment_outlined, size: 70, color: Colors.grey.shade400),
                        const SizedBox(height: 18),
                        const Text(
                          'No work orders found',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.search.isNotEmpty
                              ? 'Try changing your search or filter.'
                              : 'You have no assigned work orders.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),

                ...List.generate(state.visibleWorkOrders.length, (index) {
                  final workOrder = state.visibleWorkOrders[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: WorkOrderCard(
                      workOrder: workOrder,
                      onTap: () {
                        // TODO:
                        // Navigate to Work Order Details
                      },
                    ).animate(delay: (index * 60).ms).fadeIn().slideY(begin: .15),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
