import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class UserContainer extends StatelessWidget {
  final Widget child;
  const UserContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 308,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: ColorsShadesTheme.neutralGray1),
        child: child);
  }
}
