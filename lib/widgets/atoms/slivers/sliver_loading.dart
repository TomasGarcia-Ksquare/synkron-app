import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SliverLoading extends StatelessWidget {
  final double height;
  const SliverLoading({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: height,
      child: Lottie.asset('assets/lottie_loading.json', width: 200.0),
    ));
  }
}
