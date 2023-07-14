import 'dart:convert';
import 'dart:io';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:study_savvy_app/models/article_improver/model_article_improver.dart';
import '../api_routes.dart';
import '../utils/jwt_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class ArticleImproverService {
  JwtService jwtService;
  http.Client httpClient;

  ArticleImproverService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<void> predictOcrGraph(ArticleImage data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    File imageData=data.image;
    String text=data.prompt;
    final response = await httpClient.send(http.MultipartRequest(
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
          'Authorization': 'Bearer $jwt'
        },
      ));
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
      throw Exception('Failed in unknown reason');
    }
  }

  Future<void> predictOcrText(ArticleText data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.articleImproverTextUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
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
      await jwtService.deleteJwt();
      throw AuthException("JWT invalid");
    }
    else if(response.statusCode == 500){
      throw ServerException("Server's error");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

}