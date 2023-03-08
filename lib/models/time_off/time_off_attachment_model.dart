class TimeOffAttachmentModel {
  String? message;
  Data? data;

  TimeOffAttachmentModel({this.message, this.data});

  TimeOffAttachmentModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? type;
  String? fileName;
  String? path;
  int? timeOffRequestId;
  int? attachmentId;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.type,
      this.fileName,
      this.path,
      this.timeOffRequestId,
      this.attachmentId,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    fileName = json['fileName'];
    path = json['path'];
    timeOffRequestId = json['timeOffRequestId'];
    attachmentId = json['attachmentId'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['fileName'] = this.fileName;
    data['path'] = this.path;
    data['timeOffRequestId'] = this.timeOffRequestId;
    data['attachmentId'] = this.attachmentId;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
