import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/models/files/model_files.dart';
import 'file_test.mocks.dart';


@GenerateMocks([File])
void main() {
  group('File', () {
    test('File object value test', () {
      const String testId= 'Test id';
      const String testType = 'Test type';
      const String testStatus = 'Test status';
      const String testTime = 'Test time';
      final file = File(testId,testType,testStatus,testTime);

      expect(file.id, testId);
      expect(file.type, testType);
      expect(file.status, testStatus);
      expect(file.time, testTime);
    });
  });
  group('Files', () {
    test('Files object value test (num of files 1000)', () {
      List<MockFile> mockFiles = List<MockFile>.generate(1000, (index) {
        var mockFile = MockFile();
        when(mockFile.id).thenReturn('Test id $index');
        when(mockFile.type).thenReturn('Test type $index');
        when(mockFile.status).thenReturn('Test status $index');
        when(mockFile.time).thenReturn('Test time $index');
        return mockFile;
      });
      const int testCurrentPage=2;
      const int testTotalPage=5;

      final files = Files(mockFiles,testCurrentPage,testTotalPage);

      for (int i = 0; i < mockFiles.length; i++) {
        expect(files.files[i].id, 'Test id $i');
        expect(files.files[i].type, 'Test type $i');
        expect(files.files[i].status, 'Test status $i');
        expect(files.files[i].time, 'Test time $i');
      }
      expect(files.currentPage, testCurrentPage);
      expect(files.totalPages, testTotalPage);
    });
    test('Files object value test (num of files 10)', () {
      List<MockFile> mockFiles = List<MockFile>.generate(10, (index) {
        var mockFile = MockFile();
        when(mockFile.id).thenReturn('Test id $index');
        when(mockFile.type).thenReturn('Test type $index');
        when(mockFile.status).thenReturn('Test status $index');
        when(mockFile.time).thenReturn('Test time $index');
        return mockFile;
      });
      const int testCurrentPage=2;
      const int testTotalPage=5;

      final files = Files(mockFiles,testCurrentPage,testTotalPage);

      for (int i = 0; i < mockFiles.length; i++) {
        expect(files.files[i].id, 'Test id $i');
        expect(files.files[i].type, 'Test type $i');
        expect(files.files[i].status, 'Test status $i');
        expect(files.files[i].time, 'Test time $i');
      }
      expect(files.currentPage, testCurrentPage);
      expect(files.totalPages, testTotalPage);
    });
    test('Files object value test (num of files 0)', () {
      List<MockFile> mockFiles = List<MockFile>.generate(0, (index) {
        var mockFile = MockFile();
        when(mockFile.id).thenReturn('Test id $index');
        when(mockFile.type).thenReturn('Test type $index');
        when(mockFile.status).thenReturn('Test status $index');
        when(mockFile.time).thenReturn('Test time $index');
        return mockFile;
      });
      const int testCurrentPage=2;
      const int testTotalPage=5;

      final files = Files(mockFiles,testCurrentPage,testTotalPage);

      for (int i = 0; i < mockFiles.length; i++) {
        expect(files.files[i].id, 'Test id $i');
        expect(files.files[i].type, 'Test type $i');
        expect(files.files[i].status, 'Test status $i');
        expect(files.files[i].time, 'Test time $i');
      }
      expect(files.currentPage, testCurrentPage);
      expect(files.totalPages, testTotalPage);
    });
    test('Files object fromJson method test (num of files 10)', () {
      List<Map<String,String>> testFiles = List<Map<String,String>>.generate(10, (index) {
        var map={'file_id': 'Test id $index', 'file_type': 'Test type $index', 'status': 'Test status $index', 'file_time': 'Test time $index'};
        return map;
      });
      const int testCurrentPage=2;
      const int testTotalPage=5;

      var testJson={
        'datas':testFiles,
        'current_page':testCurrentPage,
        'total_pages': testTotalPage,
      };

      final files = Files.fromJson(testJson);

      for (int i = 0; i < files.files.length; i++) {
        expect(files.files[i].id, 'Test id $i');
        expect(files.files[i].type, 'Test type $i');
        expect(files.files[i].status, 'Test status $i');
        expect(files.files[i].time, 'Test time $i');
      }
      expect(files.currentPage, testCurrentPage);
      expect(files.totalPages, testTotalPage);
    });
  });
  group('SpecificFile', () {
    test('SpecificFiles object value test (num of files 1000)', () {
      List<String> testDetails = List<String>.generate(1000, (index) {
        return "Test $index";
      });
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      const String testSummarize="Test summarize";

      final specificFile = SpecificFile(testContent,testPrompt,testSummarize,testDetails);

      for (int i = 0; i < specificFile.details.length; i++) {
        expect(specificFile.details[i], "Test $i");
      }

      expect(specificFile.content,testContent);
      expect(specificFile.prompt,testPrompt);
      expect(specificFile.summarize,testSummarize);
    });
    test('SpecificFiles object value test (num of files 10)', () {
      List<String> testDetails = List<String>.generate(10, (index) {
        return "Test $index";
      });
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      const String testSummarize="Test summarize";

      final specificFile = SpecificFile(testContent,testPrompt,testSummarize,testDetails);

      for (int i = 0; i < specificFile.details.length; i++) {
        expect(specificFile.details[i], "Test $i");
      }

      expect(specificFile.content,testContent);
      expect(specificFile.prompt,testPrompt);
      expect(specificFile.summarize,testSummarize);
    });
    test('SpecificFiles object value test (num of files 0)', () {
      List<String> testDetails = List<String>.generate(0, (index) {
        return "Test $index";
      });
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      const String testSummarize="Test summarize";

      final specificFile = SpecificFile(testContent,testPrompt,testSummarize,testDetails);

      for (int i = 0; i < specificFile.details.length; i++) {
        expect(specificFile.details[i], "Test $i");
      }

      expect(specificFile.content,testContent);
      expect(specificFile.prompt,testPrompt);
      expect(specificFile.summarize,testSummarize);
    });
    test('SpecificFiles object fromJson method test (num of files 10)', () {
      List<String> testDetails = List<String>.generate(10, (index) {
        return "Test $index";
      });
      const String testContent="Test content";
      const String testPrompt="Test prompt";
      const String testSummarize="Test summarize";

      var testJson={
        'content': testContent,
        'prompt': testPrompt,
        'summarize': testSummarize,
        'details': testDetails
      };

      final specificFiles = SpecificFile.fromJson(testJson);

      for (int i = 0; i < specificFiles.details.length; i++) {
        expect(specificFiles.details[i], 'Test $i');
      }
      expect(specificFiles.content, testContent);
      expect(specificFiles.prompt, testPrompt);
      expect(specificFiles.summarize, testSummarize);
    });
  });

  group('EditFile', () {

    test('EditFile object value test', () {
      const String testId="Test id";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final editFile = EditFile(testId, testPrompt, testContent);

      expect(editFile.id,testId);
      expect(editFile.content,testContent);
      expect(editFile.prompt,testPrompt);

    });

    test('EditFile object formatJson method test', () {
      const String testId="Test id";
      const String testContent="Test content";
      const String testPrompt="Test prompt";

      final editFile = EditFile(testId, testPrompt, testContent);

      expect(editFile.formatJson(), {'prompt': testPrompt, 'content': testContent});

    });
  });
}