import 'package:synkron_app/models/generic_file_model.dart';

class Resume {
  int? id;
  ResumeData? resumeData;
  int? employeeId;
  int? resumePDFId;
  String? updatedAt;
  GenericFile? resumeFile;
  Resume({
    this.id,
    this.resumeData,
    this.resumePDFId,
    this.updatedAt,
    this.resumeFile,
  });
  Resume.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resumeData = ResumeData.fromJson(json['resumeData']);
    employeeId = json['employeeId'];
    resumePDFId = json['resumePDFId'];
    updatedAt = json['updatedAt'];
    if (json['file'] != null) {
      resumeFile = json['file'];
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['resumeData'] = resumeData!.toJson();
    json['resumePDFId'] = resumePDFId;
    json['updatedAt'] = updatedAt;
    return json;
  }
}

class ResumeData {
  String? resumeTitle;
  ResumeData({
    this.resumeTitle,
  });
  ResumeData.fromJson(Map<String, dynamic> json) {
    resumeTitle = json['resumeTitle'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['resumeTitle'] = resumeTitle;
    return json;
  }
}
