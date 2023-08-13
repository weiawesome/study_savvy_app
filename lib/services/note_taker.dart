import 'dart:convert';
import 'dart:io';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:study_savvy_app/models/model_noteTaker.dart';
import './api_routes.dart';
import './utils/jwt_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class noteTaker_Service {
  JwtService jwtService;
  http.Client httpClient;

  noteTaker_Service({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<void> predictASR(noteTaker_audio data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    File audioData=data.audio;
    String text=data.prompt;
    final response = await httpClient.send(http.MultipartRequest(
      'POST',
      Uri.parse(ApiRoutes.noteTakerUrl),
    )
      ..fields['prompt']=text
      ..files.add(await http.MultipartFile.fromPath(
        'file',
        audioData.path,
        contentType: MediaType('audio', 'mpeg'),
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
      throw ClientException("Fail to update ASR file.(Client's error)");
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