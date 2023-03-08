import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ResumeFileService {
  final ReceivePort _port = ReceivePort();
  getPort() {
    return _port;
  }

  setupPort() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {});
    FlutterDownloader.registerCallback(downloadCallback);
  }

  removePortMappping() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  createDownloadTask(String idPdf) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final externalDir = await getApplicationSupportDirectory();
      String appDocPath = externalDir.path;
      final taskId = await FlutterDownloader.enqueue(
        url: idPdf,
        saveInPublicStorage: true,
        headers: {},
        savedDir: appDocPath,
        showNotification: true,
        openFileFromNotification: true,
      )
          .then((value) => FlutterDownloader.loadTasksWithRawQuery(
              query:
                  'SELECT * FROM task WHERE task_id="${Uri.encodeComponent(value ?? "")}"'))
          .then((value) async {
        var lastDownloadTask = value![0].taskId;
        await FlutterDownloader.open(taskId: lastDownloadTask);
      }).catchError((e) {
        return e;
      });
    }
  }
}
