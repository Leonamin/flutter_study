import 'package:flutter/material.dart';

class CircleElevatedButton extends StatelessWidget {
  CircleElevatedButton({
    super.key,
    required this.child,
    this.radius,
    required this.onPressed,
    this.minimumSize,
    this.color,
  });

  final Widget? child;
  final double? radius;
  final VoidCallback onPressed;
  final Size? minimumSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 30),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: minimumSize ?? const Size(50, 50),
              backgroundColor: color ?? Colors.blue,
            ),
            onPressed: onPressed,
            child: child));
  }
}
