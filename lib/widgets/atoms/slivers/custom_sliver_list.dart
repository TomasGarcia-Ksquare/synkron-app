import 'package:flutter/material.dart';

class CustomSliverList extends StatelessWidget {
  final SliverChildDelegate sliverChildDelegate;
  const CustomSliverList({super.key, required this.sliverChildDelegate});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: sliverChildDelegate,
    );
  }
}
