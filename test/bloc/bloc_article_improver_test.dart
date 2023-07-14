import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/blocs/bloc_article_improver.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:study_savvy_app/services/api_article_improver.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'bloc_article_improver_test.mocks.dart';

@GenerateMocks([File,ArticleImproverService])
void main() {

  group("ArticleBloc", () {
    test('emit null when ArticleEventText build', () async {
      final ArticleBloc articleBloc=ArticleBloc();
      expect(articleBloc.state.toString(), ArticleState("INIT",null).toString());
    });
  });

  group('ArticleBloc Graph Event', () {
    test('emits [PENDING, SUCCESS] when ArticleEventGraph succeeded', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenAnswer((_) async => '');

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("SUCCESS", null).toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );

      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);

    });
    test('emits [PENDING, FAILURE-Client] when ArticleEventGraph fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenThrow(ClientException("Client's error"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "CLIENT").toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Exist] when ArticleEventGraph fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenThrow(ExistException("Source not exist"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "EXIST").toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Auth] when ArticleEventGraph fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenThrow(AuthException("JWT invalid"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "AUTH").toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Server] when ArticleEventGraph fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenThrow(ServerException("Server's error"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "SERVER").toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Unknown] when ArticleEventGraph fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrGraph(any)).thenThrow(Exception("Failed in unknown reason"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "UNKNOWN").toString(),
      ];

      const String testPrompt="Test prompt";
      final MockFile testFile=MockFile();
      ArticleImage testArticleImage=ArticleImage(testFile, testPrompt);

      articleBloc.add(ArticleEventGraph(testArticleImage));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrGraph(any));
      verify(mockArticleImproverService.predictOcrGraph(any)).called(1);
    });
  });
  
  group('ArticleBloc Text Event', () {
    test('emits [PENDING, SUCCESS] when ArticleEventText succeeded', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenAnswer((_) async => '');

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("SUCCESS", null).toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );

      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);

    });
    test('emits [PENDING, FAILURE-Client] when ArticleEventText fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenThrow(ClientException("Client's error"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "CLIENT").toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Exist] when ArticleEventText fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenThrow(ExistException("Source not exist"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "EXIST").toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Auth] when ArticleEventText fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenThrow(AuthException("JWT invalid"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "AUTH").toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Server] when ArticleEventText fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenThrow(ServerException("Server's error"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "SERVER").toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);
    });
    test('emits [PENDING, FAILURE-Unknown] when ArticleEventText fail', () async {
      final MockArticleImproverService mockArticleImproverService=MockArticleImproverService();
      final ArticleBloc articleBloc=ArticleBloc(apiService: mockArticleImproverService);

      when(mockArticleImproverService.predictOcrText(any)).thenThrow(Exception("Failed in unknown reason"));

      final expectedStates = [
        ArticleState("PENDING", null).toString(),
        ArticleState("FAILURE", "UNKNOWN").toString(),
      ];

      const testContent="Test content";
      const testPrompt="Test prompt";

      ArticleText testArticleText=ArticleText(testContent,testPrompt);

      articleBloc.add(ArticleEventText(testArticleText));
      await expectLater(
        articleBloc.stream.map((event) => event.toString()),
        emitsInOrder(expectedStates),
      );
      await untilCalled(mockArticleImproverService.predictOcrText(any));
      verify(mockArticleImproverService.predictOcrText(any)).called(1);
    });
  });

  group("ArticleBloc Refresh Event", () {
    test('emits null when Refresh', () async {
      final ArticleBloc articleBloc=ArticleBloc();
      articleBloc.add(ArticleEventRefresh());
      expect(articleBloc.state.toString(),ArticleState("INIT", null).toString());
    });
  });

  group("ArticleBloc Unknown Event", () {
    test('throw exception when Unknown happen', () async {
      final ArticleBloc articleBloc=ArticleBloc();
    });
  });
}
