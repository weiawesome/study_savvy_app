import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/article_improver/model_article_improver.dart';
import 'package:study_savvy_app/services/article_improver/api_article_improver.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'predict_ocr_text_test.mocks.dart';

@GenerateMocks([JwtService, http.Client])
void main() {
  group('predictOcrText', () {
    test('predictOcrText', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();
      
      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      
      final ArticleText testArticleText=ArticleText(testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer((_) async => http.Response('', 200),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);
      await apiService.predictOcrText(testArticleText);

      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

    });
    test('predictOcrText throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      
      final ArticleText testArticleText=ArticleText(testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer((_) async => http.Response('', 400),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrText(testArticleText), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson())));
      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

    });
    test('predictOcrText throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final ArticleText testArticleText=ArticleText( testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer((_) async => http.Response('', 404),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrText(testArticleText), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson())));
      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

    });
    test('predictOcrText throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final ArticleText testArticleText=ArticleText( testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer((_) async => http.Response('', 422),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrText(testArticleText), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson())));
      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

    });
    test('predictOcrText throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final ArticleText testArticleText=ArticleText( testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer(
            (_) async => http.Response('', 500),
      );
      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrText(testArticleText), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson())));
      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

    });
    test('predictOcrText throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final ArticleText testArticleText=ArticleText( testContent,testPrompt);

      final url = Uri.parse(ApiRoutes.articleImproverTextUrl);
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).thenAnswer(
            (_) async => http.Response('', 555),
      );
      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrText(testArticleText), throwsA(isA<Exception>()));

      await untilCalled(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson())));
      verify(httpClient.post(url, headers: {"Content-Type": "application/json",'Authorization': 'Bearer $testJwt'},body: jsonEncode(testArticleText.formatJson()))).called(1);

    });
    test('predictOcrText throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final ArticleText testArticleText=ArticleText( testContent,testPrompt);

      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expect(apiService.predictOcrText(testArticleText), throwsA(isA<AuthException>()));

    });
  });
}