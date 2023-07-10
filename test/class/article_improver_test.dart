import 'dart:io';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:test/test.dart';
import 'article_improver_test.mocks.dart';

@GenerateMocks([File])
void main() {
  group('ArticleImage', () {
    test('ArticleImage object value test', () {
      final file = MockFile();
      when(file.path).thenReturn('mocked_path');

      File testImage = file;
      const String testPrompt = 'Test prompt';
      final articleImage = ArticleImage(testImage, testPrompt);

      expect(articleImage.image, testImage);
      expect(articleImage.prompt, testPrompt);
    });
  });

  group('ArticleText', () {
    test('ArticleText object value test', () {
      const String testContent = 'Test content';
      const String testPrompt = 'Test prompt';
      final articleText = ArticleText(testContent,testPrompt);

      expect(articleText.content, testContent);
      expect(articleText.prompt, testPrompt);
    });
    test('ArticleText object formatJson method test', () {
      const String testContent = 'Test content';
      const String testPrompt = 'Test prompt';
      final articleText = ArticleText(testContent,testPrompt);

      expect(articleText.formatJson(), {'content': testContent, 'prompt': testPrompt});
    });
  });
}
