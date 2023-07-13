import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';


class FilesService {
  JwtService jwtService;
  http.Client httpClient;

  FilesService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<Uint8List?> getImage(String id) async {
    String? jwt=await jwtService.getJwt();
    final response = await http.get(
      Uri.parse("${ApiRoutes.fileImageUrl}/$id"),
      headers: {'Authorization': 'Bearer ${jwt!}'},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    else if (response.statusCode==203){
      return null;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<Uint8List> getAudio(String id) async {
    String? jwt=await jwtService.getJwt();
    final response = await http.get(
      Uri.parse("${ApiRoutes.fileAudioUrl}/$id"),
      headers: {'Authorization': 'Bearer ${jwt!}'},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<SpecificFile> getSpecificFile(String id) async {
    String? jwt=await jwtService.getJwt();
    final response = await http.get(
      Uri.parse("${ApiRoutes.fileUrl}/$id"),
      headers: {'Authorization': 'Bearer ${jwt!}'},
    );
    if (response.statusCode == 200) {
      return SpecificFile.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<Files> getFiles(int page) async {
    String? jwt=await jwtService.getJwt();
    final response = await http.get(
      Uri.parse("${ApiRoutes.fileUrl}?page=$page"),
      headers: {'Authorization': 'Bearer ${jwt!}'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return Files.fromJson(result);
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<void> deleteSpecificFile(String id) async {
    String? jwt=await jwtService.getJwt();
    final response = await http.delete(
      Uri.parse("${ApiRoutes.fileUrl}/$id"),
      headers: {'Authorization': 'Bearer ${jwt!}'},
    );
    if (response.statusCode == 201) {
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<void> editSpecificFileOCR(EditFile file) async {
    String? jwt=await jwtService.getJwt();
    final String id=file.id;
    final response = await http.put(
        Uri.parse("${ApiRoutes.fileNlpEditOCRUrl}/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt!}'
        },
        body: jsonEncode(file.formatJson())
    );

    if (response.statusCode == 200) {
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }

  Future<void> editSpecificFileASR(EditFile file) async {
    String? jwt=await jwtService.getJwt();
    final String id=file.id;
    final response = await http.put(
        Uri.parse("${ApiRoutes.fileNlpEditASRUrl}/$id"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${jwt!}'
        },
        body: jsonEncode(file.formatJson())
    );
    if (response.statusCode == 200) {
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 404){
      throw ExistException("Source not exist");
    }
    else if (response.statusCode == 422){
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed to upload in unknown reason');
    }
  }
  
}
