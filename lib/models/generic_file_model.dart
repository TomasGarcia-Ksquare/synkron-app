class GenericFile {
  String? url;
  String? downloadUrl;
  num? id;
  String? type;
  String? fileName;
  String? path;
  bool? isUploaded;
  String? createdAt;
  String? updatedAt;

  GenericFile({
    this.url,
    this.downloadUrl,
    this.id,
    this.type,
    this.fileName,
    this.path,
    this.isUploaded,
    this.createdAt,
    this.updatedAt,
  });

  GenericFile.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    downloadUrl = json['downloadUrl'];
    id = json['id'];
    type = json['type'];
    fileName = json['fileName'];
    path = json['path'];
    isUploaded = json['isUploaded'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};

    json['url'] = url;
    json['downloadUrl'] = downloadUrl;
    json['id'] = id;
    json['type'] = type;
    json['fileName'] = fileName;
    json['path'] = path;
    json['isUploaded'] = isUploaded;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;

    return json;
  }
}
