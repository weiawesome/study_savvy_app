import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/blocs/provider/ocr_image_provider.dart';
import 'ocr_image_provider_test.mocks.dart';

@GenerateMocks([File])
void main(){
  group('OCRImageProvider Test', () {

    test('Initial state is null', () {
      final ocrImageProvider = OCRImageProvider();
      expect(ocrImageProvider.image, null);
      expect(ocrImageProvider.path, null);
      expect(ocrImageProvider.file, null);
      expect(ocrImageProvider.isNull(), true);
    });

    test('Set method sets image, path, file and calls notifyListeners(Length of Image is 1000)', () async {
      final testFile = MockFile();
      const String testPath= "Test path";
      final testImage = Uint8List.fromList(List<int>.generate(1000, (index) => index % 256));

      when(testFile.path).thenReturn(testPath);
      when(testFile.readAsBytes()).thenAnswer((_) async => testImage);

      final ocrImageProvider = OCRImageProvider();
      await ocrImageProvider.set(testFile);

      expect(ocrImageProvider.image, testImage);
      expect(ocrImageProvider.path, testPath);
      expect(ocrImageProvider.file, testFile);
      expect(ocrImageProvider.isNull(), false);
    });
    test('Set method sets image, path, file and calls notifyListeners(Length of Image is 10)', () async {
      final testFile = MockFile();
      const String testPath= "Test path";
      final testImage = Uint8List.fromList(List<int>.generate(10, (index) => index % 256));

      when(testFile.path).thenReturn(testPath);
      when(testFile.readAsBytes()).thenAnswer((_) async => testImage);

      final ocrImageProvider = OCRImageProvider();
      await ocrImageProvider.set(testFile);

      expect(ocrImageProvider.image, testImage);
      expect(ocrImageProvider.path, testPath);
      expect(ocrImageProvider.file, testFile);
      expect(ocrImageProvider.isNull(), false);
    });
    test('Set method sets image, path, file and calls notifyListeners(Length of Image is 0)', () async {
      final testFile = MockFile();
      const String testPath= "Test path";
      final testImage = Uint8List.fromList(List<int>.generate(0, (index) => index % 256));

      when(testFile.path).thenReturn(testPath);
      when(testFile.readAsBytes()).thenAnswer((_) async => testImage);

      final ocrImageProvider = OCRImageProvider();
      await ocrImageProvider.set(testFile);

      expect(ocrImageProvider.image, testImage);
      expect(ocrImageProvider.path, testPath);
      expect(ocrImageProvider.file, testFile);
      expect(ocrImageProvider.isNull(), false);
    });

    test('Clear method clear image, path, file and calls notifyListeners(Length of Image is 10)', () async {
      final testFile = MockFile();
      const String testPath= "Test path";
      final testImage = Uint8List.fromList(List<int>.generate(10, (index) => index % 256));

      when(testFile.path).thenReturn(testPath);
      when(testFile.readAsBytes()).thenAnswer((_) async => testImage);

      final ocrImageProvider = OCRImageProvider();
      await ocrImageProvider.set(testFile);

      expect(ocrImageProvider.image, testImage);
      expect(ocrImageProvider.path, testPath);
      expect(ocrImageProvider.file, testFile);
      expect(ocrImageProvider.isNull(), false);

      ocrImageProvider.clear();

      expect(ocrImageProvider.image,null);
      expect(ocrImageProvider.path, null);
      expect(ocrImageProvider.file, null);
      expect(ocrImageProvider.isNull(), true);
    });
  });
}