import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';

import '../utils/exception.dart';

Future<Uint8List> getImage(String id) async {
  String? jwt=await JwtService.getJwt();
  final response = await http.get(
    Uri.parse("${ApiRoutes.fileImageUrl}/$id"),
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
    await JwtService.deleteJwt();
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
  String? jwt=await JwtService.getJwt();
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
    await JwtService.deleteJwt();
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
  String? jwt=await JwtService.getJwt();
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
    await JwtService.deleteJwt();
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
  String? jwt=await JwtService.getJwt();
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
    await JwtService.deleteJwt();
    throw AuthException("JWT invalid");
  }
  else if(response.statusCode == 500){
    throw ServerException("Server's error");
  }
  else{
    throw Exception('Failed to upload in unknown reason');
  }
}
