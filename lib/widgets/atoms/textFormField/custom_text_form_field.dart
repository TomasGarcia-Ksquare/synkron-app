import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/utils/constants.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final Function? onTap;
  final TextEditingController ctrl;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final double? verticalPadding;
  final String? Function(String?)? validation;
  final RegExp? allowedValues;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? myFocusNode;
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.onTap,
    required this.ctrl,
    this.readOnly,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.verticalPadding,
    this.validation,
    this.enabled,
    this.allowedValues,
    this.labelText,
    this.inputFormatters,
    this.myFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // height: 48,
      child: TextFormField(
        onTap: onTap != null
            ? () async {
                await onTap!();
              }
            : () {},
        controller: ctrl,
        validator: (value) {
          return validation != null ? validation!(value) : null;
        },
        focusNode: myFocusNode,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: enabled ?? true,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: inputFormatters ??
            <TextInputFormatter>[
              FilteringTextInputFormatter.allow(Constants.SEARCH_STRING_EXP),
            ],
        maxLines: maxLines ?? 1,
        style: TypographyTheme.fontBody1,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16, vertical: verticalPadding ?? 0),
          enabledBorder: grayBorder(),
          focusedBorder: primaryBlueBorder(),
          errorBorder: redBorder(),
          focusedErrorBorder: primaryBlueBorder(),
          disabledBorder: grayBorder(),
          labelText: labelText ?? '',
          labelStyle: TypographyTheme.fontBody1Placeholder,
          alignLabelWithHint: true,
          floatingLabelStyle: TypographyTheme.fontBody1AccentBlue2,
          hintText: hintText,
          hintStyle: TypographyTheme.fontBody1Placeholder,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  OutlineInputBorder redBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1, color: ColorsTheme.destructiveRed), //<-- SEE HERE
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  OutlineInputBorder primaryBlueBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1, color: ColorsTheme.primaryBlue), //<-- SEE HERE
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  OutlineInputBorder grayBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1, color: ColorsShadesTheme.neutralGray2), //<-- SEE HERE
      borderRadius: BorderRadius.circular(8.0),
    );
  }
}
