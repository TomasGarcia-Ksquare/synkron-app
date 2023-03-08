import 'package:flutter/material.dart';
import 'package:synkron_app/utils/constants.dart';
import 'package:synkron_app/utils/utils.dart';
import 'package:synkron_app/widgets/atoms/datepicker/simple_show_calendar_date_picker2_dialog.dart';
import 'package:synkron_app/widgets/atoms/textFormField/custom_text_form_field.dart';

class TextformfieldWithDatepicker extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController ctrl;
  final bool? enabled;
  final String? Function(String?)? validation;
  final bool? weekdays;
  final dynamic lastDay;
  final DateTime? initalValue;
  final DateTime? firstDate;
  const TextformfieldWithDatepicker(
      {super.key,
      required this.hintText,
      this.suffixIcon,
      required this.ctrl,
      this.enabled,
      this.labelText,
      this.validation,
      this.weekdays,
      this.lastDay,
      this.initalValue,
      this.firstDate});

  @override
  State<TextformfieldWithDatepicker> createState() =>
      _TextformfieldWithDatepickerState();
}

class _TextformfieldWithDatepickerState
    extends State<TextformfieldWithDatepicker> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
        ctrl: widget.ctrl,
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        readOnly: true,
        enabled: widget.enabled,
        validation: widget.validation,
        allowedValues: Constants.DATE_REG_EXP,
        onTap: () async {
          var pickedDate = await simpleShowCalendarDatePicker2Dialog(
            context: context,
            firstDate: widget.firstDate ??
                DateTime.now().subtract(const Duration(days: 1)),
            weekdays: widget.weekdays ?? false,
            currentDate: DateTime.now(),
            initialValue: widget.initalValue ?? DateTime.now(),
            lastDay: widget.lastDay,
          );
          if (pickedDate != null && pickedDate.isNotEmpty) {
            var date = Utils.formatDate(
                date: pickedDate[0].toString(),
                format: DateFormatInterface.MM_DD_YYY);
            widget.ctrl.text = date;
          }
        });
  }
}
