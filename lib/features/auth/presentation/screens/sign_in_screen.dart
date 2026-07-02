import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/core/router/app_routes_names.dart';
import 'package:maintly_app/core/widgets/inputs.dart';
import 'package:maintly_app/utils/assets/assets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),

                  Center(
                        child: Container(
                          width: 110,
                          height: 110,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: context.primaryColor.withOpacity(.12),
                                blurRadius: 30,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            AssetsData.logo,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .scale(
                        begin: const Offset(.8, .8),
                        curve: Curves.easeOutBack,
                      ),

                  const SizedBox(height: 32),

                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: context.primaryColorDark,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: .3),

                  const SizedBox(height: 10),

                  Text(
                    "Sign in to access your assigned work orders,\nassets and maintenance activities.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 45),

                  AuthTextFormField(
                    labelText: "Email Address",
                    controller: _emailController,
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 500.ms).slideX(begin: -.15),

                  const SizedBox(height: 18),

                  AuthTextFormField(
                    labelText: "Password",
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 650.ms).slideX(begin: .15),

                  const SizedBox(height: 8),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // TODO
                      },
                      child: const Text("Forgot Password?"),
                    ),
                  ).animate().fadeIn(delay: 750.ms),

                  const SizedBox(height: 18),

                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        // TODO: Sign in
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 850.ms).scaleX(begin: .9),

                  const SizedBox(height: 28),

                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey.shade300)),
                    ],
                  ).animate().fadeIn(delay: 950.ms),

                  const SizedBox(height: 24),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutesNames.signupScreen);
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      side: BorderSide(
                        color: context.primaryColor.withOpacity(.25),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          TextSpan(
                            text: "Create One",
                            style: TextStyle(
                              color: context.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 1050.ms).slideY(begin: .2),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "Maintly",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ).animate().fadeIn(delay: 1200.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
