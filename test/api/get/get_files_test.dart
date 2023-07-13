import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';

@GenerateMocks([JwtService, http.Client,File])
void main() {}