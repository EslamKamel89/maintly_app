import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl_standalone.dart';
import 'package:maintly_app/core/globals.dart';
import 'package:maintly_app/core/router/app_router.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/service_locator/service_locator.dart';
import 'package:maintly_app/core/themes/theme_cubit.dart';
import 'package:maintly_app/core/widgets/keyboard_dismiss_on_scroll.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  await findSystemLocale();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/langs', // Path to translation files
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeCubit())],
      child: Builder(
        builder: (context) {
          final themeCubit = context.watch<ThemeCubit>();
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: themeCubit.state,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutesNames.splashScreen,
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: serviceLocator<AppRouter>().onGenerateRoute,
            builder: (context, child) => KeyboardDismissOnScroll(child: child ?? SizedBox()),
          );
        },
      ),
    );
  }
}
