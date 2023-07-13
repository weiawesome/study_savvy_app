import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'logout_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group("Delete method of logout", () {
    test('logout', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 201),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
      await apiService.logout();

      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('logout throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();
      
      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 400),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.logout(), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('logout throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();
      
      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 404),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.logout(), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('logout throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 422),);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.logout(), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

    });
    test('logout throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.logout(), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('logout throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";

      final url = Uri.parse(ApiRoutes.logoutUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.logout(), throwsA(isA<Exception>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('logout throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.logout(), throwsA(isA<AuthException>()));

    });
  });
}