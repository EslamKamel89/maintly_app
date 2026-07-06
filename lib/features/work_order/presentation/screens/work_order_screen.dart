import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maintly_app/core/enums/api_status.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_cubit.dart';
import 'package:maintly_app/features/work_order/presentation/controllers/work_order/work_order_state.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/animated_section_divider.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/asset_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/empty_section.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/section_title.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/technician_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/work_order_description_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/work_order_hero_card.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/work_order/work_order_timeline_card.dart';

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

        return Scaffold(
          appBar: AppBar(title: const Text('Work Order'), centerTitle: false),

          body: switch (state.status) {
            ApiStatus.initial || ApiStatus.loading => const _LoadingView(),

            ApiStatus.error when state.workOrder == null => _ErrorView(
              message: state.errorMessage,
              onRetry: () => cubit.load(workOrderId),
            ),

            _ => RefreshIndicator(
              onRefresh: () => cubit.refresh(workOrderId),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                children: [
                  if (state.status == ApiStatus.refreshing)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 18),
                      child: LinearProgressIndicator(),
                    ),

                  if (state.workOrder != null) ...[
                    Builder(
                      builder: (context) {
                        final workOrder = state.workOrder!;

                        return Column(
                          children: [
                            WorkOrderHeroCard(
                              workOrder: workOrder,
                            ).animate().fadeIn().slideY(begin: -.08),

                            const AnimatedSectionDivider(),

                            if ((workOrder.description ?? '').trim().isNotEmpty)
                              WorkOrderDescriptionCard(description: workOrder.description!),

                            const AnimatedSectionDivider(),

                            const SectionTitle(
                              title: 'Assigned Technicians',
                              icon: Icons.engineering_rounded,
                            ),

                            if (workOrder.technicians != null && workOrder.technicians!.isNotEmpty)
                              ...workOrder.technicians!.map(
                                (technician) => TechnicianCard(technician: technician),
                              )
                            else
                              const EmptySection(
                                title: 'No Technician Assigned',
                                message:
                                    'This work order has not yet been assigned to any technician.',
                                icon: Icons.engineering_outlined,
                              ),

                            const AnimatedSectionDivider(),

                            const SectionTitle(
                              title: 'Assets',
                              icon: Icons.precision_manufacturing_rounded,
                            ),

                            if (workOrder.assets != null && workOrder.assets!.isNotEmpty)
                              ...workOrder.assets!.map((asset) => AssetCard(asset: asset))
                            else
                              const EmptySection(
                                title: 'No Assets',
                                message: 'No assets have been linked to this work order.',
                                icon: Icons.precision_manufacturing_outlined,
                              ),

                            const AnimatedSectionDivider(),

                            WorkOrderTimelineCard(workOrder: workOrder),

                            const SizedBox(height: 40),
                          ],
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          },
        );
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
