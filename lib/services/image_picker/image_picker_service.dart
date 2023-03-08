import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  pickPhoto() async {
    final photo = await _picker.pickImage(source: ImageSource.camera);
  }

  pickMultipleImages() async {
    final List<XFile> uploadImages = await _picker.pickMultiImage();
  }
}
