import 'package:flutter/material.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/router/middleware.dart';
import 'package:maintly_app/core/screens_example/on_boarding_screen/on_bording_screen.dart';
import 'package:maintly_app/core/screens_example/splash_screen/splash_screen.dart';
import 'package:maintly_app/core/widgets/ui_components_screen.dart';

class AppRouter {
  AppMiddleWare appMiddleWare;
  AppRouter({required this.appMiddleWare});
  Route? onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    String? routeName = appMiddleWare.middlleware(routeSettings.name);
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
