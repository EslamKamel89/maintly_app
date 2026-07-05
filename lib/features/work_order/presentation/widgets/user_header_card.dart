import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/features/auth/models/response/user.dart';

class UserHeaderCard extends StatefulWidget {
  const UserHeaderCard({super.key, required this.user});

  final User user;

  @override
  State<UserHeaderCard> createState() => _UserHeaderCardState();
}

class _UserHeaderCardState extends State<UserHeaderCard> with TickerProviderStateMixin {
  bool _expanded = true;
  Timer? _collapseTimer;

  @override
  void initState() {
    super.initState();

    _collapseTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _expanded = false;
      });
    });
  }

  @override
  void dispose() {
    _collapseTimer?.cancel();
    super.dispose();
  }

  void _toggle() {
    _collapseTimer?.cancel();

    setState(() {
      _expanded = !_expanded;
    });
  }

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "Good Morning";
    }

    if (hour >= 12 && hour < 17) {
      return "Good Afternoon";
    }

    if (hour >= 17) {
      return "Good Evening";
    }

    return "Welcome";
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [context.primaryColor, context.primaryColorDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: context.primaryColor.withOpacity(.25),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: _toggle,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: const TextStyle(color: Colors.white70, fontSize: 15),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.user.name ?? "",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Text(
                            (widget.user.name?.isNotEmpty ?? false)
                                ? widget.user.name![0].toUpperCase()
                                : "?",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: context.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 26)
                            .animate(target: _expanded ? 1 : 0)
                            .rotate(begin: 0, end: .5, duration: 300.ms, curve: Curves.easeInOut),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axisAlignment: -1,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: !_expanded
                  ? const SizedBox.shrink()
                  : Column(
                      key: const ValueKey('expanded'),
                      children: [
                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.18),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              widget.user.role ?? "",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 22),

                        _InfoTile(
                          icon: Icons.business_outlined,
                          text: widget.user.organization?.name ?? "",
                        ),

                        const SizedBox(height: 10),

                        _InfoTile(icon: Icons.email_outlined, text: widget.user.email ?? ""),

                        const SizedBox(height: 28),

                        const Row(
                          children: [
                            Expanded(
                              child: _StatCard(value: "0", title: "Assigned"),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(value: "0", title: "In Progress"),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(value: "0", title: "Completed"),
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.title});

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
