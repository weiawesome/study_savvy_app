import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'set_api_key_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test('set-api-key', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',200));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    await apiService.setApiKey(testAccessToken);

    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);

  });
  test('set-api-key throws ClientException', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',400));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<ClientException>()));

    await untilCalled(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')));
    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);

  });
  test('set-api-key throws ExistException', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',404));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<ExistException>()));

    await untilCalled(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')));
    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);
  });
  test('set-api-key throws AuthException', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',422));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<AuthException>()));

    await untilCalled(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')));
    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);

    await untilCalled(jwtService.deleteJwt());
    verify(jwtService.deleteJwt()).called(1);

  });
  test('set-api-key throws ServerException', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',500));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<ServerException>()));

    await untilCalled(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')));
    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);
  });
  test('set-api-key throws Other Exception', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testJwt="Test jwt";
    const String testAccessToken="Test api_key";

    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')))
        .thenAnswer((_) async => http.Response('',555));

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<Exception>()));

    await untilCalled(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body')));
    verify(httpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).called(1);

  });
  test('set-api-key throws AuthException(Jwt is null)', () async {
    final jwtService = MockJwtService();
    final httpClient = MockClient();

    const String testAccessToken="Test api_key";
    when(jwtService.getJwt()).thenAnswer((_) async => null);

    final ProfileService apiService = ProfileService(jwtService: jwtService, httpClient: httpClient);
    expectLater(apiService.setApiKey(testAccessToken), throwsA(isA<AuthException>()));
  });
}