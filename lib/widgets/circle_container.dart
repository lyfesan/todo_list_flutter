import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    this.child,
    required this.color,
    this.borderWidth,
  });

  final Color color;
  final Widget? child;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            width: borderWidth ?? 2,
            color: color,
          )
      ),
      child: Center(child: child),
    );
  }
}
