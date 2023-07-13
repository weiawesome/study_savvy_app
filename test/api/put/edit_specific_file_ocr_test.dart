import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'edit_specific_file_OCR_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group('editSpecificFileOCR', () {
    test('editSpecificFileOCR', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer((_) async => http.Response('', 200),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);
      await apiService.editSpecificFileOCR(testEditFile);

      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

    });
    test('editSpecificFileOCR throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer((_) async => http.Response('', 400),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

    });
    test('editSpecificFileOCR throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer((_) async => http.Response('', 404),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

    });
    test('editSpecificFileOCR throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer((_) async => http.Response('', 422),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

    });
    test('editSpecificFileOCR throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

    });
    test('editSpecificFileOCR throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      final url = Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<Exception>()));

      await untilCalled(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson())));
      verify(httpClient.put(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testEditFile.formatJson()))).called(1);

    });
    test('editSpecificFileOCR throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final EditFile testEditFile=EditFile(testId, testPrompt, testContent);

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.editSpecificFileOCR(testEditFile), throwsA(isA<AuthException>()));

    });
  });
}