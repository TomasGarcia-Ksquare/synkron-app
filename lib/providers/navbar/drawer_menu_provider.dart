import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DrawerMenuProvider {
  var secure = const FlutterSecureStorage();

  Future<void> logout() async {
    await secure.delete(key: 'token');
    await secure.delete(key: 'refresh_token');
  }
}
