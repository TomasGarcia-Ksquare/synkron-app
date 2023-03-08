import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  Future<bool> checkInternet() async {
    return await check().then((intenet) {
      if (intenet != null && intenet) {
        return true;
      } else {
        return false;
      }
    });
  }
}
