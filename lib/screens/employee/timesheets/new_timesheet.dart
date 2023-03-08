import 'package:flutter/material.dart';
import 'package:synkron_app/screens/employee/timesheets/new_timesheet_lists.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/textFormField/custom_text_form_field.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:synkron_app/widgets/molecules/modal/custom_bottom_modal.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_canva_widget.dart';
import 'package:synkron_app/widgets/molecules/textformfield/text_form_field_with_datepicker.dart';
import 'package:synkron_app/widgets/organism/modal_attach_file/attach_file_widget.dart';

class NewTimeSheet extends StatefulWidget {
  const NewTimeSheet({super.key});

  @override
  State<NewTimeSheet> createState() => _NewTimeSheetState();
}

class _NewTimeSheetState extends State<NewTimeSheet> {
  final TextEditingController _datePicker = TextEditingController();
  final TextEditingController _projectPicker = TextEditingController();

  final _viewController = ScrollController();
  SizedBox spaceBox16 = const SizedBox(height: 16);
  SizedBox spaceBox4 = const SizedBox(height: 16);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(
          title: "New Timesheet", textStyle: TypographyTheme.fontH2AccentBlue2),
      backgroundColor: ColorsTheme.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          controller: _viewController,
          child: Column(children: [
            Row(children: [spaceBox16]),
            //DATE PICKER
            TextformfieldWithDatepicker(
                labelText: "Select date",
                enabled: true,
                hintText: "Select date",
                ctrl: _datePicker),

            //SELECT A PROJECT
            const SizedBox(height: 16),
            CustomTextFormField(
                hintText: "Select a Project",
                labelText: "Select a Project",
                ctrl: _projectPicker),

            // ExpandedButton(onPressed: () {}, text: "Select a Project"),

            //WEEK DROPDOWNS
            spaceBox16,
            NewTimeSheetLists(index: 0),
            NewTimeSheetLists(index: 1),
            NewTimeSheetLists(index: 2),
            NewTimeSheetLists(index: 3),
            NewTimeSheetLists(index: 4),
            //ATTACH FILE

            Container(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload Document',
                    style: TypographyTheme.fontH2AccentBlue2,
                  ),
                ],
              ),
            ),
            spaceBox16,
            ExpandedButton(
                bgColor: ColorsTheme.white,
                textStyle: TypographyTheme.fontBtnPrimaryBlue,
                onPressed: () {
                  CustomBottomModal().customShowModalBottomSheet(
                    context,
                    ModalCanvaWidget(
                      widget: AttachFileWidget(),
                    ),
                  );
                },
                text: 'Attach File'),
            const SizedBox(height: 4),
            const Text(
                'The file must be the in .PDF, .JPG or .PNG format, and less than 5 MB. A photo can also be taken with the camera.'),
            spaceBox16,
            ExpandedButton(
                bgColor: ColorsTheme.white,
                textStyle: TypographyTheme.fontBtnPrimaryBlue,
                onPressed: null,
                text: "Submit")
          ]),
        ),
      ),
    );
  }
}
