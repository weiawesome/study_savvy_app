import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:study_savvy_app/services/encrypt.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Encryption Test', () {
    test('encrypt function', () async {
      const text = 'This is some text to encrypt';
      final SecureData secureData = await encrypt(text);

      expect(secureData.key, isNotNull);
      expect(secureData.data, isNotNull);
    });

    test('parsePublicKeyFromPemFile function', () async {
      final fakeBundle = TestAssetBundle();
      ServicesBinding.instance.defaultBinaryMessenger.setAssetBundle(fakeBundle);
      final publicKey = await parsePublicKeyFromPemFile('assets/keys/public_key.pem');

      expect(publicKey, isNotNull);
    });
  });
}

class TestAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) async {
    final data = '-----BEGIN PUBLIC KEY-----\n...'
        '\n-----END PUBLIC KEY-----\n';
    return ByteData.view(Uint8List.fromList(data.codeUnits).buffer);
  }

  @override
  Future<String> loadString(String key, {bool cache = true}) {
    final data = '-----BEGIN PUBLIC KEY-----\n...'
        '\n-----END PUBLIC KEY-----\n';
    return Future.value(data);
  }
}
