import 'package:flutter/material.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({
    super.key,
    this.radius = 20,
    required this.height,
    required this.width,
    required this.widget,
    this.alignment,
    this.isBackgroundColor = true,
    this.color
  });
  final double radius;
  final double height;
  final double width;
  final Widget widget;
  final AlignmentGeometry? alignment;
  final bool isBackgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: isBackgroundColor ? Colors.white.withOpacity(0.1) : color != null ? color : null,
      ),
      child: Center(child: widget),
    );
  }
}
