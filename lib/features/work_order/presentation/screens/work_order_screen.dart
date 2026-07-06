import 'package:flutter/material.dart';

class WorkOrderScreen extends StatelessWidget {
  const WorkOrderScreen({super.key, required this.workOrderId});
  final int workOrderId;
  @override
  Widget build(BuildContext context) {
    return Text(workOrderId.toString());
  }
}
