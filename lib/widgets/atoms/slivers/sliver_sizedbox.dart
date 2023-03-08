import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  final double height;
  const SliverSizedBox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: SizedBox(height: height));
  }
}
