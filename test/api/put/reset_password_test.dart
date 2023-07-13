import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'reset_password_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group('resetPassword', () {
    test('resetPassword', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();
      
      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer((_) async => http.Response('', 200),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
      await apiService.resetPassword(testUpdatePwd);

      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

    });
    test('resetPassword throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer((_) async => http.Response('', 400),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.resetPassword(testUpdatePwd), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

    });
    test('resetPassword throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer((_) async => http.Response('', 404),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.resetPassword(testUpdatePwd), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

    });
    test('resetPassword throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer((_) async => http.Response('', 422),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.resetPassword(testUpdatePwd), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

    });
    test('resetPassword throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.resetPassword(testUpdatePwd), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

    });
    test('resetPassword throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      final url = Uri.parse(ApiRoutes.passwordEditUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.resetPassword(testUpdatePwd), throwsA(isA<Exception>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testUpdatePwd.formatJson()))).called(1);

    });
    test('resetPassword throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();
      
      const String testOldPwd="Test oldPwd";
      const String testNewPwd="Test newPwd";

      final UpdatePwd testUpdatePwd=UpdatePwd(testOldPwd,testNewPwd);

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.resetPassword(testUpdatePwd), throwsA(isA<AuthException>()));

    });
  });
}