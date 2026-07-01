import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class KeyboardDismissOnScroll extends StatelessWidget {
  final Widget child;
  const KeyboardDismissOnScroll({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        if (notification.direction != ScrollDirection.idle) {
          FocusScope.of(context).unfocus();
        }
        return false;
      },
      child: child,
    );
  }
}
