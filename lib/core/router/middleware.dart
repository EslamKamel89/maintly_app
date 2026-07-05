import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppMiddleWare {
  SharedPreferences sharedPreferences;
  final authService = serviceLocator<AuthService>();

  AppMiddleWare({required this.sharedPreferences});
  final List<String> publicRoutes = [
    AppRoutesNames.splashScreen,
    AppRoutesNames.onBoardingScreen,
    AppRoutesNames.signinScreen,
    AppRoutesNames.signupScreen,
  ];

  String? middleware(String? routeName) {
    if (!authService.isSignedIn() && !publicRoutes.contains(routeName)) {
      return AppRoutesNames.signinScreen;
    }
    return routeName;
  }
}
