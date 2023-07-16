import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/article_improver/model_article_improver.dart';
import 'package:study_savvy_app/services/article_improver/api_article_improver.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'predict_ocr_graph_test.mocks.dart';


@GenerateMocks([JwtService, http.Client,File])
void main() {
  group('predictOcrGraph', () {
    test('predictOcrGraph', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage(testFile,testPrompt);
      
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer((_) async => http.StreamedResponse(const Stream.empty(),200),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);
      await apiService.predictOcrGraph(testArticleImage);

      verify(httpClient.send(any)).called(1);

      await testFile.delete();

    });
    test('predictOcrGraph throws ClientException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";
      
      final ArticleImage testArticleImage=ArticleImage(testFile,testPrompt);
      
      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer((_) async => http.StreamedResponse(const Stream.empty(), 400),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrGraph(testArticleImage), throwsA(isA<ClientException>()));

      await untilCalled(httpClient.send(any));
      verify(httpClient.send(any)).called(1);

      await testFile.delete();
    });
    test('predictOcrGraph throws ExistException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage( testFile,testPrompt);

      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer((_) async => http.StreamedResponse(const Stream.empty(), 404),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrGraph(testArticleImage), throwsA(isA<ExistException>()));

      await untilCalled(httpClient.send(any));
      verify(httpClient.send(any)).called(1);

      await testFile.delete();
    });
    test('predictOcrGraph throws AuthException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage( testFile,testPrompt);

      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer((_) async => http.StreamedResponse(const Stream.empty(), 422),);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrGraph(testArticleImage), throwsA(isA<AuthException>()));

      await untilCalled(httpClient.send(any));
      verify(httpClient.send(any)).called(1);

      await untilCalled(jwtService.deleteJwt());
      verify(jwtService.deleteJwt()).called(1);

      await testFile.delete();
    });
    test('predictOcrGraph throws ServerException', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage( testFile,testPrompt);

      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer(
            (_) async => http.StreamedResponse(const Stream.empty(), 500),
      );
      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrGraph(testArticleImage), throwsA(isA<ServerException>()));

      await untilCalled(httpClient.send(any));
      verify(httpClient.send(any)).called(1);

      await testFile.delete();
    });
    test('predictOcrGraph throws Other Exception', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      const String testJwt="Test jwt";
      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage( testFile,testPrompt);

      when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
      when(httpClient.send(any)).thenAnswer(
            (_) async => http.StreamedResponse(const Stream.empty(), 555),
      );
      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);

      expectLater(apiService.predictOcrGraph(testArticleImage), throwsA(isA<Exception>()));

      await untilCalled(httpClient.send(any));
      verify(httpClient.send(any)).called(1);

      await testFile.delete();

    });
    test('predictOcrGraph throws AuthException(Jwt is null)', () async {
      final jwtService = MockJwtService();
      final httpClient = MockClient();

      File testFile = File('${Directory.systemTemp.path}/test.jpg');
      await testFile.writeAsBytes(List<int>.generate(10, (index) => index%256));
      const String testPrompt="Test prompt";

      final ArticleImage testArticleImage=ArticleImage( testFile,testPrompt);
      when(jwtService.getJwt()).thenAnswer((_) async => null);

      final ArticleImproverService apiService = ArticleImproverService(jwtService: jwtService, httpClient: httpClient);
      expect(apiService.predictOcrGraph(testArticleImage), throwsA(isA<AuthException>()));

      await testFile.delete();

    });
  });
}