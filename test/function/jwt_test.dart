import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'jwt_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('JwtService', () {
    test('JwtService saveJwt test', () async {
      MockFlutterSecureStorage storage=MockFlutterSecureStorage();
      when(storage.write(key: anyNamed('key'), value: anyNamed('value'))).thenAnswer((_) => Future.value());
      JwtService jwtService=JwtService(storage: storage);
      await jwtService.saveJwt('test_jwt');
      verify(storage.write(key: 'jwt', value: 'test_jwt')).called(1);
    });
    test('JwtService getJwt test', () async {
      MockFlutterSecureStorage storage=MockFlutterSecureStorage();
      when(storage.read(key: anyNamed('key'))).thenAnswer((_) => Future.value());
      JwtService jwtService=JwtService(storage: storage);
      await jwtService.getJwt();
      verify(storage.read(key: 'jwt')).called(1);
    });
    test('JwtService deleteJwt test', () async {
      MockFlutterSecureStorage storage=MockFlutterSecureStorage();
      when(storage.delete(key: anyNamed('key'))).thenAnswer((_) => Future.value());
      JwtService jwtService=JwtService(storage: storage);
      await jwtService.deleteJwt();
      verify(storage.delete(key: 'jwt')).called(1);
    });
    test('JwtService hasJwt returns true when jwt exists', () async {
      final storage = MockFlutterSecureStorage();

      when(storage.containsKey(key: anyNamed('key'))).thenAnswer((_) => Future.value(true));

      final jwtService = JwtService(storage: storage);

      bool? result = await jwtService.hasJwt();

      verify(storage.containsKey(key: 'jwt')).called(1);

      expect(result, isTrue);
    });

    test('JwtService hasJwt returns false when jwt does not exist', () async {
      final storage = MockFlutterSecureStorage();

      when(storage.containsKey(key: anyNamed('key'))).thenAnswer((_) => Future.value(false));

      final jwtService = JwtService(storage: storage);

      bool? result = await jwtService.hasJwt();

      verify(storage.containsKey(key: 'jwt')).called(1);

      expect(result, isFalse);
    });

  });
}
