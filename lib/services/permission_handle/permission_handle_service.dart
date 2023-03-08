import 'package:permission_handler/permission_handler.dart';

class PermissionHandleService {
  Future<bool> checkPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      return false;
    } else if (status.isPermanentlyDenied) {
      return false;
    }
    return false;
  }
}
