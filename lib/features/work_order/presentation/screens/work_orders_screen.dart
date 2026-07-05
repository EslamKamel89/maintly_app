import 'package:flutter/material.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/auth/services/auth_service.dart';
import 'package:maintly_app/features/work_order/presentation/widgets/user_header_card.dart';

class WorkOrderScreen extends StatefulWidget {
  const WorkOrderScreen({super.key});

  @override
  State<WorkOrderScreen> createState() => _WorkOrderScreenState();
}

class _WorkOrderScreenState extends State<WorkOrderScreen> {
  final AuthService _authService = serviceLocator<AuthService>();

  @override
  Widget build(BuildContext context) {
    final user = _authService.getCachedUser();
    // serviceLocator<SharedPreferences>().clear();
    return Scaffold(
      appBar: AppBar(title: const Text("Work Orders"), centerTitle: false),
      body: SafeArea(
        child: user == null
            ? const Center(child: Text("No cached user found."))
            : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      UserHeaderCard(user: user),

                      const SizedBox(height: 20),
                      TextField(decoration: InputDecoration(hintText: 'SEARCH')),
                      const SizedBox(height: 20),
                      // todo: replace the ListView.builder with the actual work order fetched from the backend
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          return SizedBox(child: Text('Work Order $i'));
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
