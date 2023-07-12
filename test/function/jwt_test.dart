import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'jwt_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('JwtService', () {
    test('saveJwt saves jwt', () async {
      MockFlutterSecureStorage storage=MockFlutterSecureStorage();
      when(storage.write(key: anyNamed('key'), value: anyNamed('value'))).thenAnswer((_) => Future.value());
      await JwtService.saveJwt('test_jwt');
      verify(storage.write(key: 'jwt', value: 'test_jwt')).called(1);
    });
  });
}
