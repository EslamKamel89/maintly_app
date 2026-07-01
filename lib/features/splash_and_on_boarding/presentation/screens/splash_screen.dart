import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(context, AppRoutesNames.onBoardingScreen, (_) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: context.scaffoldBackgroundColor,
        child: Stack(
          children: [
            // Decorative blurred circle
            Positioned(
              top: -140,
              left: -100,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
                  child: Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.primaryColor.withOpacity(.18),
                    ),
                  ),
                ),
              ),
            ),

            // Secondary decorative circle
            Positioned(
              bottom: -120,
              right: -80,
              child: IgnorePointer(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                  child: Container(
                    width: 240,
                    height: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.primaryColor.withOpacity(.08),
                    ),
                  ),
                ),
              ),
            ),

            SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                            width: 140,
                            height: 140,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(34),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.08),
                                  blurRadius: 25,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Image.asset("assets/images/logo.png"),
                          )
                          .animate()
                          .fadeIn(duration: 700.ms)
                          .scale(
                            begin: const Offset(.75, .75),
                            curve: Curves.easeOutBack,
                            duration: 900.ms,
                          )
                          .shimmer(delay: 900.ms, duration: 1200.ms),

                      const SizedBox(height: 36),

                      Text(
                            "Maintly",
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColorDark,
                              letterSpacing: 1,
                            ),
                          )
                          .animate(delay: 400.ms)
                          .fadeIn(duration: 700.ms)
                          .slideY(begin: .35, end: 0, curve: Curves.easeOutCubic),

                      const SizedBox(height: 12),

                      Text(
                        "Maintenance Management System",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade700, height: 1.5),
                      ).animate(delay: 700.ms).fadeIn(duration: 700.ms).slideY(begin: .25),

                      const SizedBox(height: 70),

                      SizedBox(
                        width: 180,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const LinearProgressIndicator(minHeight: 5),
                        ),
                      ).animate(delay: 1000.ms).fadeIn(duration: 500.ms).slideX(begin: -.3),

                      const SizedBox(height: 24),

                      Text(
                        "Version 1.0",
                        style: TextStyle(color: Colors.grey.shade500, letterSpacing: 1),
                      ).animate(delay: 1500.ms).fadeIn(duration: 600.ms),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
