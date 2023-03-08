import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/api/base_api.dart';

class UploadImageService with BaseApi {
  //Funcion para crear una url para almacenar un file en aws
  generateAwsUrlFile(String fileName) async {
    http.Response resp = await executeHttpRequest(
        //TO DO Dynamic file name
        urlMethod: 'file',
        method: 'POST',
        body: {"type": "image", "fileName": fileName});
    print(resp.body);
    try {
      return WsResponse(success: true, data: jsonDecode(resp.body));
    } catch (e) {
      return WsResponse(
          success: false, message: 'An error occurred uploading the image');
    }
  }

  //Funcion para subir un archivo binario en el link de aws
  uploadFileToAws(String url, String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();
    http.Response resp = await http.put(Uri.parse(url), body: bytes);
  }

  // //Funcion para obtener una url de un endpoing
  // Future<String> getFileWithId(String url, int id) async {
  //   http.Response resp = await http.get(Uri.parse('$url/$id'));
  //   try {
  //     return resp.body;
  //   } catch (e) {
  //     return '';
  //   }
  // }

}
