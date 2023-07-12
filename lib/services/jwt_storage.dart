import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtService {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  final FlutterSecureStorage _storage;

  JwtService({FlutterSecureStorage? storage})
      : _storage = storage ?? FlutterSecureStorage(aOptions: _getAndroidOptions());


  static const _jwtKey = 'jwt';

  Future<void> saveJwt(String jwt) async {
    await _storage.write(key: _jwtKey, value: jwt);
  }

  Future<String?> getJwt() async {
    return _storage.read(key: _jwtKey);
  }

  Future<void> deleteJwt() async {
    await _storage.delete(key: _jwtKey);
  }
  Future<bool?> hasJwt() async {
    return _storage.containsKey(key: _jwtKey);
  }
}
