import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synkron_app/models/employee/employee_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/providers/employee/time_off/time_off_request_provider.dart';
import 'package:synkron_app/providers/upload_image/upload_image_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/atoms/slivers/sliver_sizedbox.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/app_bar/custom_app_bar_widget.dart';
import 'package:synkron_app/widgets/organism/modal_attach_file/attach_file_widget.dart';
import 'package:synkron_app/widgets/molecules/modal/custom_bottom_modal.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_canva_widget.dart';
import 'package:synkron_app/widgets/molecules/slivers/title_and_description_sliver.dart';
import 'package:synkron_app/widgets/organism/time_off_request/comments_section.dart';
import 'package:synkron_app/widgets/organism/time_off_request/manager_info.dart';
import 'package:synkron_app/widgets/organism/time_off_request/start_end_date_section.dart';
import 'package:synkron_app/widgets/organism/time_off_request/time_off_types.dart';
import 'package:synkron_app/widgets/organism/time_off_request/time_requested_section.dart';

class CreateTimeOffRequestScreen extends StatefulWidget {
  const CreateTimeOffRequestScreen({super.key});

  @override
  State<CreateTimeOffRequestScreen> createState() =>
      _CreateTimeOffRequestScreenState();
}

class _CreateTimeOffRequestScreenState
    extends State<CreateTimeOffRequestScreen> {
  late FocusNode timeFocusNode;
  @override
  void initState() {
    super.initState();
    Provider.of<TimeOffRequestProvider>(context, listen: false).getUserInfo();
    timeFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
    Provider.of<TimeOffRequestProvider>(context, listen: false)
        .addTextFormFieldsListeners();

    Provider.of<TimeOffRequestProvider>(context, listen: false)
        .removeInputListeners();
  }

  _creatingSuccess(scaffoldMessengerState) {
    Navigator.pop(context);
    successSnackBar(
        scaffoldMessengerState, 'Time off request was created successfully');
  }

  _creatingFailed(scaffoldMessengerState) {
    // Navigator.pop(context);
    errorSnackBar(scaffoldMessengerState, 'Something went wrong');
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    timeFocusNode.dispose();

    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TimeOffRequestProvider timeOffRequestProvider =
        Provider.of<TimeOffRequestProvider>(context);
    ScaffoldMessengerState scaffoldMessengerState =
        ScaffoldMessenger.of(context);
    UploadImageProvider uploadImageProvider = UploadImageProvider();
    return Scaffold(
      backgroundColor: ColorsTheme.backgroundBlue,
      appBar: customAppBar(
        title: 'Create Request',
        textStyle: TypographyTheme.fontSub1AccentBlue2,
      ),
      body: Consumer<TimeOffRequestProvider>(
        builder: (timeoffRequestScreen, provider, child) {
          EmployeeProfileModel user = provider.user;
          if (provider.loading == false) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    top: 16,
                  ),
                  sliver: SliverToBoxAdapter(
                      child: ManagerInfo(manager: user.manager!)),
                ),
                const TitleAndDescriptionSliver(
                  title: 'Time Off Type',
                  description: 'Select the Time Off that you want to take.',
                ),
                const TimeOffTypes(),
                const SliverSizedBox(height: 48),
                SliverToBoxAdapter(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const StartEndDateSection(),
                        const SizedBox(height: 48),
                        TimeRequestedSection(
                          myFocusNode: timeFocusNode,
                        ),
                        const SizedBox(height: 48),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Upload Document',
                                style: TypographyTheme.fontH2AccentBlue2,
                              ),
                              const SizedBox(height: 16),
                              ExpandedButton(
                                  onPressed: () {
                                    CustomBottomModal()
                                        .customShowModalBottomSheet(
                                      context,
                                      ModalCanvaWidget(
                                        widget: AttachFileWidget(),
                                      ),
                                    );
                                  },
                                  text: 'Attach File'),
                              const SizedBox(height: 4),
                              const Text(
                                  'The file must be the in .JPG or .PNG format, and no more than 5 MB. A photo can also be taken with the camera.'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        const CommentsSection(),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ExpandedButton(
                              bgColor: ColorsTheme.primaryBlue,
                              textStyle: TypographyTheme.fontBtnWhite,
                              onPressed: provider.formfilled == false
                                  ? null
                                  : () async {
                                      if (formKey.currentState!.validate()) {
                                        WsResponse response = await provider
                                            .createTimeOffRequest();
                                        dynamic resp = response.data as Map;
                                        print(resp);
                                        if (resp.isEmpty) {
                                          if (provider.maxTimeError) {
                                            timeFocusNode.requestFocus();
                                          }
                                          errorSnackBar(scaffoldMessengerState,
                                              'Error in requested hours');
                                        } else if (resp['message'] ==
                                            'Created') {
                                          _creatingSuccess(
                                              scaffoldMessengerState);

                                          // WsResponse
                                          //     responseAttachment = await timeOffRequestProvider
                                          //         .attachImageToTimeOffRequest(
                                          //             uploadImageProvider
                                          //                 .imageModel!
                                          //                 .data!
                                          //                 .fileName,
                                          //             resp['data']['id'],
                                          //             uploadImageProvider
                                          //                 .imageModel!
                                          //                 .data!
                                          //                 .id);
                                          // print(
                                          //     'This is the response from the attachment: ${responseAttachment.data}');
                                        } else {
                                          _creatingFailed(
                                              scaffoldMessengerState);
                                        }
                                      } else {
                                        warningSnackBar(scaffoldMessengerState,
                                            'Some fields are wrong');
                                      }
                                    },
                              text: 'Submit'),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return showLoadingInfoWidget();
        },
      ),
    );
  }
}
