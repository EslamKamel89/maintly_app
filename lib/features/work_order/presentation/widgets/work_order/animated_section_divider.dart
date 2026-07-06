import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedSectionDivider extends StatelessWidget {
  const AnimatedSectionDivider({super.key, this.verticalPadding = 24});

  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).dividerColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: TweenAnimationBuilder<double>(
        duration: 700.ms,
        curve: Curves.easeOutCubic,
        tween: Tween(begin: 0, end: 1),
        builder: (context, value, child) {
          return Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withOpacity(0),
                      color.withOpacity(.35),
                      color.withOpacity(.65),
                      color.withOpacity(.35),
                      color.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
