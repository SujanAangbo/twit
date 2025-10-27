import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScaffold extends StatelessWidget {
  const ShimmerScaffold({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      child: child,
    );
  }
}
