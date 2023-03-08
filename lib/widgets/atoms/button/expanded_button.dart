import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';

class ExpandedButton extends StatelessWidget {
  final dynamic onPressed;
  final Color? bgColor;
  final String text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final IconData? icon;
  final Color? iconColor;

  const ExpandedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
    this.textStyle,
    this.borderColor,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    Color bgNormal = bgColor ?? ColorsTheme.white;
    Color borderNormal = borderColor ?? ColorsTheme.primaryBlue;
    Color bgDisabled = ColorsShadesTheme.disabledGray1;
    TextStyle textStyleNormal = textStyle ?? TypographyTheme.fontBtnPrimaryBlue;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : () {
                onPressed();
              },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: onPressed == null ? bgDisabled : bgNormal,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: onPressed == null ? bgDisabled : borderNormal,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: icon == null
            ? Text(
                text,
                style: onPressed == null
                    ? TypographyTheme.fontBtnDisabled
                    : textStyleNormal,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(text,
                      style: textStyle ?? TypographyTheme.fontBtnPrimaryBlue),
                  const SizedBox(
                    width: 8,
                  ),
                  Icon(icon, color: iconColor),
                ],
              ),
      ),
    );
  }
}
