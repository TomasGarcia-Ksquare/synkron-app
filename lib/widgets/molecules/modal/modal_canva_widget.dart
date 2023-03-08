import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class ModalCanvaWidget extends StatelessWidget {
  Widget widget;

  ModalCanvaWidget({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorsTheme.backgroundBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      margin: const EdgeInsets.only(top: 80),
      padding: const EdgeInsets.only(top: 10),
      child: widget,
    );
  }
}
