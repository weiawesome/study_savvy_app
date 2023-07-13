import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:study_savvy_app/services/api_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import '../api_test.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  final jwtService = MockJwtService();
  final httpClient = MockClient();

  test('Fetch specific file', () async {
    const String testId="Test id";
    const String testJwt="Test jwt";
    final url = Uri.parse("${ApiRoutes.fileUrl}$testId");
    when(jwtService.getJwt()).thenAnswer((_) async => testJwt);
    when(httpClient.delete(url, headers: {'Authorization': 'Bearer $testJwt'})).thenAnswer(
          (_) async => http.Response('', 201),
    );

    final FilesService apiService = FilesService(jwtService: jwtService, httpClient: httpClient);
    await apiService.deleteSpecificFile(testId);

  });
}
