import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/blocs/bloc_jwt.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_routes.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';

Future<Uint8List> getImage(String ID) async {
  String? jwt=await JwtService.getJwt();
  final response = await http.get(
    Uri.parse(API_Routes.File_image_url+"/"+ID),
    headers: {'Authorization': 'Bearer '+jwt!},
  );
  if (response.statusCode == 200) {
    return response.bodyBytes;
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    JWTBloc().add(JWTEventGet());
    throw Exception('Failed to load image');
  }
  else{
    throw Exception('Failed to load image');
  }
}

Future<Specific_File> getSpecificFile(String ID) async {
  String? jwt=await JwtService.getJwt();
  final response = await http.get(
    Uri.parse(API_Routes.File_url+"/"+ID),
    headers: {'Authorization': 'Bearer '+jwt!},
  );
  if (response.statusCode == 200) {
    return Specific_File.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    JWTBloc().add(JWTEventGet());
    throw Exception('Failed to load image');
  }
  else{
    throw Exception('Failed to load image');
  }
}

Future<Files> getFiles(int page) async {
  String? jwt=await JwtService.getJwt();
  final response = await http.get(
    Uri.parse(API_Routes.File_url+"?page="+page.toString()),
    headers: {'Authorization': 'Bearer '+jwt!},
  );
  if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(response.body);
    return Files.fromJson(result);
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    JWTBloc().add(JWTEventGet());
    throw Exception('Failed to load image');
  }
  else{
    throw Exception('Failed to load image');
  }
}
