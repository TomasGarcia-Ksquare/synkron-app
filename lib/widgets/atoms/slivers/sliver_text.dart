import 'package:flutter/material.dart';

class SliverText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const SliverText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class SliverTextHeight extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double height;

  const SliverTextHeight(
      {super.key,
      required this.text,
      required this.style,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: SizedBox(
      height: height,
      child: Center(child: Text(text, style: style)),
    ));
  }
}
