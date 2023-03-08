import 'package:flutter/material.dart';

class Custom2SliverGrid extends StatelessWidget {
  final SliverChildDelegate sliverChildDelegate;
  const Custom2SliverGrid({super.key, required this.sliverChildDelegate});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width ~/ 170,
        childAspectRatio: 0.60,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 16.0,
      ),
      delegate: sliverChildDelegate,
    );
  }
}
