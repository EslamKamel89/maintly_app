import 'package:flutter/material.dart';
import 'package:maintly_app/core/globals.dart';

Future<bool?> showAreYouSureDialog() async {
  final context = navigatorKey.currentContext;

  if (context == null) {
    return null;
  }

  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final theme = Theme.of(context);
      final colorScheme = theme.colorScheme;

      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: colorScheme.error.withOpacity(.10),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.logout_rounded, size: 30, color: colorScheme.error),
            ),
            const SizedBox(height: 20),
            const Text(
              'Log Out?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to log out of your Maintly account?',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, height: 1.5, color: theme.colorScheme.onSurfaceVariant),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
