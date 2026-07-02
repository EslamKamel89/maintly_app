import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/core/widgets/inputs.dart';
import 'package:maintly_app/utils/assets/assets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _organizationController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _organizationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    "Create Your Organization",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: context.primaryColorDark,
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: .3),

                  const SizedBox(height: 10),

                  Text(
                    "Create your organization and owner account\n"
                    "to start managing maintenance activities.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 45),

                  AuthTextFormField(
                    labelText: "Organization Name",
                    controller: _organizationController,
                    prefixIcon: Icons.business_outlined,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Organization name is required";
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 450.ms).slideX(begin: -.15),

                  const SizedBox(height: 18),

                  AuthTextFormField(
                    labelText: "Full Name",
                    controller: _nameController,
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Full name is required";
                      }
                      return null;
                    },
                  ).animate().fadeIn(delay: 550.ms).slideX(begin: .15),

                  const SizedBox(height: 18),

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
                  ).animate().fadeIn(delay: 650.ms).slideX(begin: -.15),

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

                      if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      }

                      return null;
                    },
                  ).animate().fadeIn(delay: 750.ms).slideX(begin: .15),

                  const SizedBox(height: 18),

                  AuthTextFormField(
                    labelText: "Confirm Password",
                    controller: _confirmPasswordController,
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please confirm your password";
                      }

                      if (value != _passwordController.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ).animate().fadeIn(delay: 850.ms).slideX(begin: -.15),

                  const SizedBox(height: 30),

                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        // TODO: Call /auth/register
                      },
                      child: const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 950.ms).scaleX(begin: .9),

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
                  ).animate().fadeIn(delay: 1050.ms),

                  const SizedBox(height: 24),

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: context.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 1150.ms).slideY(begin: .2),

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
                  ).animate().fadeIn(delay: 1300.ms),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
