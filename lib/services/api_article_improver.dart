import 'dart:convert';
import 'dart:io';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'api_routes.dart';
import 'jwt_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<void> predictOcrGraph(ArticleImage data) async {
  String? jwt=await JwtService.getJwt();
  File imageData=data.image;
  String text=data.prompt;
  final response = await (http.MultipartRequest(
    'POST',
    Uri.parse(ApiRoutes.articleImproverUrl),
  )
    ..fields['prompt']=text
    ..files.add(await http.MultipartFile.fromPath(
      'file',
      imageData.path,
      contentType: MediaType('image', 'jpeg'),
    ))
    ..headers.addAll(
    {
      'Authorization': 'Bearer ${jwt!}'
    },
  )).send();
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

Future<void> predictOcrText(ArticleText data) async {
  String? jwt=await JwtService.getJwt();
  final response = await http.post(
    Uri.parse(ApiRoutes.articleImproverTextUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${jwt!}'
    },
    body: jsonEncode(data.formatJson()),
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