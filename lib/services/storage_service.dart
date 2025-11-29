import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token, {String key = 'jwt_token'}) async {
    await _storage.write(key: key, value: token);
  }

  static Future<String?> getToken({String key = 'jwt_token'}) async {
    return _storage.read(key: key);
  }

  static Future<void> deleteToken({String key = 'jwt_token'}) async {
    await _storage.delete(key: key);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
