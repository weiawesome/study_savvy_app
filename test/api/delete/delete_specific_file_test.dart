import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/files/api_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:http/http.dart' as http;
import 'delete_specific_file_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group("Delete method of deleteSpecificFile", () {
    test('deleteSpecificFile', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 201),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);
      await apiService.deleteSpecificFile(testId);

      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('deleteSpecificFile throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 400),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.deleteSpecificFile(testId), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('deleteSpecificFile throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 404),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.deleteSpecificFile(testId), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('deleteSpecificFile throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 422),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.deleteSpecificFile(testId), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

    });
    test('deleteSpecificFile throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.deleteSpecificFile(testId), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('deleteSpecificFile throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.deleteSpecificFile(testId), throwsA(isA<Exception>()));

      await untilCalled(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('deleteSpecificFile throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.deleteSpecificFile(testId), throwsA(isA<AuthException>()));

    });
  });
}
