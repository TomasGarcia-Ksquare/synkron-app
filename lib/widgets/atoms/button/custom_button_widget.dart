import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
    required this.type,
    this.iconLeft,
  }) : super(key: key);

  final String text;
  IconData? icon;
  final dynamic onPressed;
  final int type; // 1 = white button, else = blue button
  bool? iconLeft;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor:
            type == 1 ? ColorsTheme.white : ColorsTheme.primaryBlue,
        side: const BorderSide(color: ColorsTheme.primaryBlue),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: icon != null
          ? iconLeft == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: type == 1
                          ? ColorsTheme.primaryBlue
                          : ColorsTheme.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      text,
                      style: type == 1
                          ? TypographyTheme.fontBtnPrimaryBlue
                          : TypographyTheme.fontBtnWhite,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: type == 1
                          ? TypographyTheme.fontBtnPrimaryBlue
                          : TypographyTheme.fontBtnWhite,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      icon,
                      color: type == 1
                          ? ColorsTheme.primaryBlue
                          : ColorsTheme.white,
                    ),
                  ],
                )
          : Text(
              text,
              style: type == 1
                  ? TypographyTheme.fontBtnPrimaryBlue
                  : TypographyTheme.fontBtnWhite,
            ),
    );
  }
}
