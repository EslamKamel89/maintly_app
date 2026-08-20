import 'package:flutter/material.dart';
import 'package:maintly_app/core/globals.dart';
import 'package:maintly_app/core/heleprs/print_helper.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/features/notifications/models/notification_model.dart';

Future<void> onNotificationClick(NotificationModel model) async {
  final t = 'notification model - onNotificationClick handler';
  pr(model, t);
  var context = navigatorKey.currentContext;
  if (context == null) return;
  if (model.routeName == AppRoutesNames.workOrderScreen) {
    final workOrderId = model.payload?['work_order_id'];

    if (workOrderId == null) {
      pr(null, 'Notification does not contain a work_order_id');
      return;
    }

    await Navigator.of(
      context,
    ).pushNamed(AppRoutesNames.workOrderScreen, arguments: {'workOrderId': workOrderId});
  }
}
