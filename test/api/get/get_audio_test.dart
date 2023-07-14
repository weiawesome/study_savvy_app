import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/files/api_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'get_audio_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group("Get method of getAudio", (){
    test('getAudio(Length of audio is 1000)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      final Uint8List testResult= Uint8List.fromList(List<int>.generate(1000, (index) => index));

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response.bytes(testResult, 200));

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      final Uint8List result=await apiService.getAudio(testId);

      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);
      
      expect(result, equals(testResult));
      expect(result, isA<Uint8List>());

    });
    test('getAudio(Length of audio is 10)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      final Uint8List testResult= Uint8List.fromList(List<int>.generate(10, (index) => index));

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response.bytes(testResult, 200));

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      final Uint8List result=await apiService.getAudio(testId);

      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

      expect(result, equals(testResult));
      expect(result, isA<Uint8List>());

    });
    test('getAudio(Length of audio is 0)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";
      final Uint8List testResult= Uint8List.fromList(List<int>.generate(0, (index) => index));

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response.bytes(testResult, 200));

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      final Uint8List result=await apiService.getAudio(testId);

      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

      expect(result, equals(testResult));
      expect(result, isA<Uint8List>());

    });
    test('getAudio throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 400),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.getAudio(testId), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('getAudio throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 404),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.getAudio(testId), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('getAudio throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer((_) async => http.Response('', 422),);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.getAudio(testId), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

      await untilCalled(jwtService.getJwt());
      verify(jwtService.getJwt()).called(1);

    });
    test('getAudio throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.getAudio(testId), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('getAudio throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";
      const String testJwt="Test jwt";

      final url = Uri.parse("${ApiRoutes.fileAudioUrl}/$testId");
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.getAudio(testId), throwsA(isA<Exception>()));

      await untilCalled(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'}));
      verify(httpClient.get(url, headers: {'Authorization': 'Bearer $testJwt'})).called(1);

    });
    test('getAudio throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testId="Test id";

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.getAudio(testId), throwsA(isA<AuthException>()));

    });
  });
}