import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/services/utils/jwt_storage.dart';

@GenerateMocks([JwtService, http.Client])
void main() {}