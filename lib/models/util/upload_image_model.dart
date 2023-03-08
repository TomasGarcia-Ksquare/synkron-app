class UploadImageModel {
  String? message;
  Data? data;
  bool isUploadingImage = false;

  UploadImageModel({this.message, this.data});

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int id = 0;
  String? type;
  String fileName = '';
  String? path;
  bool? isUploaded;
  String? updatedAt;
  String? createdAt;
  String? uploadUrl;

  Data(
      {required this.id,
      this.type,
      required this.fileName,
      this.path,
      this.isUploaded,
      this.updatedAt,
      this.createdAt,
      this.uploadUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    fileName = json['fileName'];
    path = json['path'];
    isUploaded = json['isUploaded'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    uploadUrl = json['uploadUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['isUploaded'] = this.isUploaded;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['uploadUrl'] = this.uploadUrl;
    return data;
  }
}
