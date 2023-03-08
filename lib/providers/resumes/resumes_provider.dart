import 'package:flutter/material.dart';
import 'package:synkron_app/extensions/camel_case_extension.dart';
import 'package:synkron_app/models/generic_file_model.dart';
import 'package:synkron_app/models/resume_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/services/resumes/resumes_service.dart';
import 'package:synkron_app/utils/utils.dart';

class ResumesProvider extends ChangeNotifier {
  List<Resume> resumesList = [];
  bool loadingResumes = false;
  ResumesProvider();

  Future getResumes() async {
    List<Resume> resumes = [];
    WsResponse wsResponse = await ResumesService().getOwnResumes();
    if (wsResponse.success) {
      dynamic bodyResponse = wsResponse.data;
      if (bodyResponse != null && bodyResponse['data'].isNotEmpty) {
        dynamic dataResponse = bodyResponse['data'];
        dataResponse.removeWhere((item) =>
            item['resumePDFId'] == null ||
            item['isVisibleToManager'] == false ||
            item['isPublished'] == false);
        resumes = dataResponse.map<Resume>((e) => Resume.fromJson(e)).toList();
        resumes.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
        return resumes;
      }
      return resumes;
    }
    return resumes;
  }

  Future<dynamic> getResumeFile(int id) async {
    WsResponse wsResponse = await ResumesService().getResumeFile(id);
    if (wsResponse.success) {
      dynamic bodyResponse = wsResponse.data;
      if (bodyResponse == null || bodyResponse.length == 0) {
        return null;
      }
      if (bodyResponse['data'].isNotEmpty) {
        GenericFile resumeFile = GenericFile.fromJson(bodyResponse['data']);
        return resumeFile;
      }
      return null;
    }
    return wsResponse.message;
  }

  Future<void> getResumesWithFilesList() async {
    if (resumesList.isNotEmpty) {
      for (Resume item in resumesList) {
        var file = await getResumeFile(item.resumePDFId!);
        if (file != null) {
          item.resumeFile = file;
        }
      }
    }
    notifyListeners();
  }

  loadData() async {
    loadingResumes = true;
    resumesList = await getResumes();
    await getResumesWithFilesList();
    loadingResumes = false;
    notifyListeners();
  }

  formatUpdatedDate(String date) {
    return Utils.formatDate(
            date: date, format: DateFormatInterface.DD_MM_YY_HH_MM_A)
        .toLowerCase()
        .capitalize();
  }
}
