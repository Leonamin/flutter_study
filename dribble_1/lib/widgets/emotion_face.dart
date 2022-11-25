import 'package:flutter/material.dart';

class EmotionFace extends StatelessWidget {
  final String icon;
  final double? size;
  const EmotionFace({super.key, required this.icon, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue[600], borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(12),
      child: Text(
        icon,
        style: TextStyle(fontSize: size),
      ),
    );
  }
}
