import 'package:flutter/material.dart';

import '../../../styles/colors_theme.dart';

class CustomScrollToTopFAB extends StatelessWidget {
  const CustomScrollToTopFAB(
      {super.key, required this.heroTag, required this.scrollController});

  final String heroTag;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
        );
      },
      backgroundColor: ColorsTheme.white,
      child: const Icon(
        Icons.keyboard_arrow_up_outlined,
        color: ColorsTheme.primaryBlue,
        size: 36.0,
      ),
    );
  }
}
