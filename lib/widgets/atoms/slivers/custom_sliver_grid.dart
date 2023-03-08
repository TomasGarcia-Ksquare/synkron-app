import 'package:flutter/material.dart';

class CustomSliverGrid extends StatelessWidget {
  final SliverChildDelegate sliverChildDelegate;
  const CustomSliverGrid({super.key, required this.sliverChildDelegate});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        childAspectRatio: 0.73,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 16.0,
      ),
      delegate: sliverChildDelegate,
    );
  }
}
