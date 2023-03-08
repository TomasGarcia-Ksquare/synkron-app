import 'package:flutter/material.dart';
import 'package:synkron_app/styles/colors_theme.dart';

class TypographyTheme {
  static const fontFamilyTitle = 'Roboto';
  static const fontFamilyText = 'Nunito-Sans';
  static const fontH1TextColor = TextStyle(
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.01,
    color: ColorsTheme.textColor,
  );
  static const fontH1AccentBlue2 = TextStyle(
    fontSize: 32,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.01,
    color: ColorsTheme.accentBlue2,
  );
  static const fontH2 = TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.005,
    color: ColorsTheme.textColor,
  );
  static final fontH2PrimaryBlue = fontH2.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static final fontH2AccentBlue2 = fontH2.merge(
    const TextStyle(
      color: ColorsTheme.accentBlue2,
    ),
  );
  static final fontH2Placeholder = fontH2.merge(
    const TextStyle(
      color: ColorsShadesTheme.placeholderText,
    ),
  );
  static const fontH3 = TextStyle(
    fontSize: 20,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0.01,
    color: ColorsTheme.textColor,
  );
  static final fontH3AccentBlue = fontH3.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  // style not included in the typography table
  static const fontH4 = TextStyle(
    fontSize: 18,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w700,
    height: 24 / 18,
    letterSpacing: 0.01,
    color: ColorsTheme.textColor,
  );
  static final fontH4AccentBlue2 = fontH4.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontH4AccentBlue3 = fontH4.merge(const TextStyle(
    color: ColorsTheme.accentBlue3,
  ));
  // style not included in the typography table
  static const fontH5 = TextStyle(
    fontSize: 16,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    letterSpacing: 0.0125,
    color: ColorsTheme.textColor,
  );
  // style for menu items
  static final fontH5PrimaryBlue = fontH4.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static const fontH6 = TextStyle(
    fontSize: 14,
    color: ColorsTheme.textColor,
    fontWeight: FontWeight.w700,
    fontFamily: 'Nunito-sans',
  );
  static const fontSub1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w700,
    height: 1.5,
    letterSpacing: 0,
    color: ColorsTheme.textColor,
  );
  static final fontSub1PrimaryBlue = fontSub1.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static final fontSub1AccentBlue2 = fontSub1.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontSub1DisableGray2 = fontSub1.merge(const TextStyle(
    color: ColorsShadesTheme.disabledGray2,
  ));
  static const fontSubH2 = TextStyle(
    fontSize: 14,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w700,
    height: 20 / 14,
    letterSpacing: 0.01,
    color: ColorsTheme.textColor,
  );
  static final fontSubH2PrimaryBlue = fontSubH2.merge(
    const TextStyle(color: ColorsTheme.primaryBlue),
  );
  static final fontSubH2AccentBlue2 = fontSubH2.merge(
    const TextStyle(color: ColorsTheme.accentBlue2),
  );
  static final fontSubH2White = fontSubH2.merge(
    const TextStyle(color: ColorsTheme.white),
  );
  static const fontBody1 = TextStyle(
    fontSize: 16,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.002,
    color: ColorsTheme.textColor,
  );
  static const fontBody1CalendarWhite = TextStyle(
    fontSize: 16,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.002,
    color: ColorsTheme.white,
  );

  static final fontBody1AccentBlue2 = fontBtn.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontBody1Placeholder = fontBtn.merge(const TextStyle(
    color: ColorsShadesTheme.placeholderText,
  ));
  static const fontBody2 = TextStyle(
    fontSize: 14,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.002,
    color: ColorsTheme.textColor,
  );
  static const fontBody3 = TextStyle(
    fontSize: 12,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.008,
    color: ColorsTheme.textColor,
  );
  static const fontBody3White = TextStyle(
    fontSize: 12,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.08,
    color: ColorsTheme.white,
  );
  static final fontBody3AccentBlue2 = fontBody3.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontBody3PrimaryBlue = fontBody3.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static final fontBody3DisableGray2 = fontBody3.merge(const TextStyle(
    color: ColorsShadesTheme.disabledGray2,
  ));
  // H4
  static const fontBtn = TextStyle(
    fontSize: 18,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w700,
    height: 24 / 18,
    letterSpacing: 0.01,
    color: ColorsTheme.textColor,
  );
  static final fontBtnAccentBlue2 = fontBtn.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontBtnPrimaryBlue = fontBtn.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static final fontBtnWhite = fontBtn.merge(const TextStyle(
    color: ColorsTheme.white,
  ));
  static final fontBtnDisabled = fontBtn.merge(const TextStyle(
    color: ColorsShadesTheme.disabledGray2,
  ));
  static const fontCap = TextStyle(
    fontSize: 12,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w700,
    height: 16 / 12,
    letterSpacing: 0.008,
    color: ColorsTheme.textColor,
  );

  static final fontCapPrimaryBlue = fontCap.merge(const TextStyle(
    color: ColorsTheme.primaryBlue,
  ));
  static final fontCapAccentBlue2 = fontCap.merge(const TextStyle(
    color: ColorsTheme.accentBlue2,
  ));
  static final fontCapWhite = fontCap.merge(const TextStyle(
    color: ColorsTheme.white,
  ));
  static final fontCapDisableGray2 = fontCap.merge(const TextStyle(
    color: ColorsShadesTheme.disabledGray2,
  ));
  static const fontOver = TextStyle(
    fontSize: 12,
    fontFamily: 'Nunito-Sans',
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.015,
    color: ColorsTheme.textColor,
  );
  static const fontToast = TextStyle(
    fontSize: 14,
    fontFamily: 'Rubik',
    fontWeight: FontWeight.w400,
    height: 24 / 14,
    letterSpacing: 0.002,
    color: ColorsShadesTheme.neutralGray1,
  );
}
