import 'package:flutter/material.dart';
import 'package:maintly_app/core/globals.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/auth/services/auth_service.dart';

Future<void> continueToApp() async {
  final authService = serviceLocator<AuthService>();
  await Future.delayed(const Duration(seconds: 4));
  final ctx = navigatorKey.currentState?.context;
  if (ctx == null) return;
  if (authService.isSignedIn()) {
    Navigator.pushNamedAndRemoveUntil(ctx, AppRoutesNames.workOrdersScreen, (_) => false);
  } else if (!authService.isOnBoardingSeen()) {
    Navigator.pushNamedAndRemoveUntil(ctx, AppRoutesNames.onBoardingScreen, (_) => false);
  } else {
    Navigator.pushNamedAndRemoveUntil(ctx, AppRoutesNames.signinScreen, (_) => false);
  }
}
