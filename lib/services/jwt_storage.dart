import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtService {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  static const _jwtKey = 'jwt';

  static Future<void> saveJwt(String jwt) async {
    await _storage.write(key: _jwtKey, value: jwt);
  }

  static Future<String?> getJwt() async {
    return _storage.read(key: _jwtKey);
  }

  static Future<void> deleteJwt() async {
    await _storage.delete(key: _jwtKey);
  }
}
