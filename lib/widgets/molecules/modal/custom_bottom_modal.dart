import 'package:flutter/material.dart';

class CustomBottomModal {
  Future<void> customShowModalBottomSheet(
      BuildContext navContext, Widget modalCanvaWidget) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: navContext,
      builder: ((context) {
        return modalCanvaWidget;
      }),
    );
  }
}
