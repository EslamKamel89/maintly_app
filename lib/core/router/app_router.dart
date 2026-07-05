import 'package:flutter/material.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/router/middleware.dart';
import 'package:maintly_app/core/widgets/ui_components_screen.dart';
import 'package:maintly_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:maintly_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:maintly_app/features/splash_and_on_boarding/presentation/screens/on_bording_screen.dart';
import 'package:maintly_app/features/splash_and_on_boarding/presentation/screens/splash_screen.dart';
import 'package:maintly_app/features/work_order/presentation/screens/work_orders_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middleware(routeSettings.name);
    switch (routeName) {
      case AppRoutesNames.splashScreen:
        return CustomPageRoute(builder: (context) => const SplashScreen(), settings: routeSettings);
      case AppRoutesNames.onBoardingScreen:
        return CustomPageRoute(
          builder: (context) => const OnboardingScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.uiComponentScreen:
        return CustomPageRoute(
          builder: (context) => const UiComponentScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signinScreen:
        return CustomPageRoute(builder: (context) => const SignInScreen(), settings: routeSettings);
      case AppRoutesNames.workOrderScreen:
        return CustomPageRoute(
          builder: (context) => const WorkOrderScreen(),
          settings: routeSettings,
        );
      case AppRoutesNames.signupScreen:
        return CustomPageRoute(builder: (context) => const SignUpScreen(), settings: routeSettings);

      default:
        return null;
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute({required super.builder, required RouteSettings super.settings});
  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
