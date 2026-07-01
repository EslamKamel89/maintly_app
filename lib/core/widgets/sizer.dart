import 'package:flutter/material.dart';

class Sizer extends StatelessWidget {
  const Sizer({super.key, this.height, this.width});
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width ?? 10, height: height ?? 10);
  }
}
