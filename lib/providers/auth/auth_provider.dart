import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:synkron_app/models/authentication/auth_model.dart';
import 'package:synkron_app/models/util/ws_rensponse_model.dart';
import 'package:synkron_app/providers/network/network_check_provider.dart';
import 'package:synkron_app/services/auth/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthModel auth = AuthModel();
  var storage = const FlutterSecureStorage();
  bool storedToken = false;
  bool isLoading = false;
  bool isNetwork = false;

  AuthProvider() {
    validateStoredToken();
  }

  Future<bool> getAccessToken(String temporalToken) async {
    var exchangeTemporalToken =
        await AuthService().exchangeTemporalToken(temporalToken);
    auth = AuthModel.fromJson(exchangeTemporalToken);
    if (auth.message == 'Ok') {
      var validateToken = await AuthService().validateToken(auth.accessToken);
      if (validateToken['message'] == 'Ok') {
        storage.write(key: 'token', value: auth.accessToken);
        storage.write(key: 'refresh_token', value: auth.refreshToken);
        //String? tokenstoraje = await storage.read(key: 'token');
        //print(tokenstoraje);
        //token = auth.accessToken!;
        return true;
      }
      return false;
    }
    return false;
  }

  validateStoredToken() async {
    isNetwork = await NetworkCheck().checkInternet();
    if (isNetwork) {
      isLoading = true;
      notifyListeners();
      String? token = await storage.read(key: 'token');
      if (token != null) {
        var validateToken = await AuthService().validateToken(token);
        if (validateToken['message'] == 'Ok') {
          storedToken = true;
          notifyListeners();
        } else {
          storedToken = false;
          isLoading = false;
          notifyListeners();
        }
      } else {
        isLoading = false;
        notifyListeners();
      }
    } else {
      print('Network error');
    }
  }

  Future<bool> emailAuth(email, password) async {
    isLoading = true;
    notifyListeners();
    WsResponse emailLogin = await AuthService().emailLogin(email, password);
    dynamic data = emailLogin.data;
    if (data['message'] == 'Ok') {
      String token = data['data']['token'];
      String refreshToken = data['data']['refresh_token']['token'];
      var validateToken = await AuthService().validateToken(token);
      if (validateToken['message'] == 'Ok') {
        storage.write(key: 'token', value: token);
        storage.write(key: 'refresh_token', value: refreshToken);
        isLoading = false;
        notifyListeners();
        return true;
      }
      isLoading = false;
      notifyListeners();
      return false;
    }
    isLoading = false;
    notifyListeners();
    return false;
  }
}
