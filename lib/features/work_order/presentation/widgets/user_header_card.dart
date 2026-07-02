import 'package:flutter/material.dart';
import 'package:maintly_app/core/extensions/context-extensions.dart';
import 'package:maintly_app/features/auth/models/response/user.dart';

class UserHeaderCard extends StatelessWidget {
  const UserHeaderCard({super.key, required this.user});

  final User user;

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
    return Container(
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(greeting, style: const TextStyle(color: Colors.white70, fontSize: 15)),
                    const SizedBox(height: 6),
                    Text(
                      user.name ?? "",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  (user.name?.isNotEmpty ?? false) ? user.name![0].toUpperCase() : "?",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: context.primaryColor,
                  ),
                ),
              ),
            ],
          ),
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
                user.role ?? "",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 22),
          _InfoTile(icon: Icons.business_outlined, text: user.organization?.name ?? ""),
          const SizedBox(height: 10),
          _InfoTile(icon: Icons.email_outlined, text: user.email ?? ""),
          const SizedBox(height: 28),
          Row(
            children: const [
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
        const Icon(Icons.circle, size: 0),
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
