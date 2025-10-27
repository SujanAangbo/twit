import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    this.height = 60,
    this.width = double.infinity,
    this.isCircle = false,
    super.key,
  });

  final double height;
  final double width;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: Colors.white54,
        shape: isCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
      ),
    );
  }
}
