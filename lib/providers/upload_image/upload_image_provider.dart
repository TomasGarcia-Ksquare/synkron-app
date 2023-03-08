import 'package:flutter/foundation.dart';
import 'package:synkron_app/models/util/upload_image_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/time_off/time_off_service.dart';
import 'package:synkron_app/services/upload_image/upload_image_service.dart';

class UploadImageProvider with ChangeNotifier {
  final UploadImageService uploadImageService = UploadImageService();
  UploadImageModel? imageModel;

  //Genera una URL para subir una imagen
  Future<WsResponse> generateUploadUrl(String fileName) async {
    final response = await uploadImageService.generateAwsUrlFile(fileName);
    if (response.success) {
      imageModel = UploadImageModel.fromJson(response.data);
      notifyListeners();
    }
    return response;
  }

  //Sube una imagen a una URL generada previamente
  Future<WsResponse> uploadImageToAws(file, uploadImageUrl) async {
    if (imageModel == null) {
      return WsResponse(
          success: false, message: 'No se ha generado la URL de subida');
    }
    final uploadUrl = imageModel!.data?.uploadUrl;
    final response =
        await uploadImageService.uploadFileToAws(uploadUrl!, file.path);
    notifyListeners();
    return WsResponse(
        success: true, message: 'La imagen se ha subido con éxito');
  }

  uploadingImageIsLoading() {
    return imageModel?.isUploadingImage = true;
  }

  uploadingImageIsNotLoading() {
    return imageModel?.isUploadingImage = false;
  }
}
