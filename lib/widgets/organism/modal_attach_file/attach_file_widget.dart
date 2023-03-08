import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:synkron_app/providers/upload_image/upload_image_provider.dart';
import 'package:synkron_app/styles/colors_theme.dart';
import 'package:synkron_app/styles/font_styles.dart';
import 'package:synkron_app/widgets/atoms/button/expanded_button.dart';
import 'package:synkron_app/widgets/atoms/loading_widget/show_loading_info_widget.dart';
import 'package:synkron_app/widgets/atoms/snackbar/custom_snackbar.dart';
import 'package:synkron_app/widgets/molecules/modal/modal_appbar_widget.dart';

class AttachFileWidget extends StatelessWidget {
  AttachFileWidget({super.key});
  UploadImageProvider uploadImageProvider = UploadImageProvider();

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    final ImagePicker _picker = ImagePicker();
    final UploadImageProvider uploadImageProvider = UploadImageProvider();
    return Scaffold(
      appBar: ModalAppbarWidget(
          appBar: AppBar(), title: 'Attach File', icon: Icons.attach_file),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Upload an image from your gallry or take a photo from your device camera.',
          style: TypographyTheme.fontBody1,
        ),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              ExpandedButton(
                onPressed: () async {
                  final photo =
                      await _picker.pickImage(source: ImageSource.camera);
                  final uploadImageUrl =
                      uploadImageProvider.generateUploadUrl(photo!.name);

                  uploadImageUrl.then((value) async {
                    uploadImageProvider.uploadingImageIsLoading();

                    final response = await uploadImageProvider.uploadImageToAws(
                        photo, uploadImageUrl);
                    Navigator.pop(context);
                    successSnackBar(scaffoldMessengerState, 'Image uploaded');
                    uploadImageProvider.uploadingImageIsNotLoading();
                  }).catchError((error) {
                    errorSnackBar(
                        scaffoldMessengerState, 'Error uploading image');
                  });
                },
                bgColor: ColorsTheme.white,
                text: 'Take Photo',
                textStyle: TypographyTheme.fontBtnPrimaryBlue,
                icon: Icons.camera_alt,
                iconColor: ColorsTheme.primaryBlue,
              ),
              const SizedBox(
                height: 8,
              ),
              ExpandedButton(
                onPressed: () async {
                  final List<XFile> uploadImages =
                      await _picker.pickMultiImage();
                  //To do upload multiple images
                },
                bgColor: ColorsTheme.primaryBlue,
                text: 'Upload',
                textStyle: TypographyTheme.fontBtnWhite,
                icon: Icons.upload,
              )
            ],
          ),
        )
      ],
    );
  }
}
