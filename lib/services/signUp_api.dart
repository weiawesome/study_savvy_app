import 'dart:convert';
import 'dart:io';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:study_savvy_app/models/model_signup.dart';
import './api_routes.dart';
import './utils/jwt_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


class SignUpService {
  JwtService jwtService;
  http.Client httpClient;

  SignUpService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<void> sendEmailConfirmation(SignUpModel data) async {
    print(jsonEncode(data.formatJson()));
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.emailSendUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'mail':data.mail}),
    );

    if (response.statusCode == 200) {
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

  Future<bool> verifyEmail(SignUpModel data, String verificationCode) async {
    
    final response = await httpClient.get(
      Uri.parse('${ApiRoutes.emailCheckUrl}/${data.mail}/$verificationCode'),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      //驗證成功
      await signup(data);
      return true;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

  Future<void> signup(SignUpModel data) async {
    
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.signUpUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
      },
      body: jsonEncode(data.formatJson()),
    );
    print(jsonEncode(data.formatJson()));
    print(response.body);
    if (response.statusCode == 200) {
      return ;
    }else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }else if(response.statusCode == 401){
      throw ClientException("Unauthorized with information. User have been signup for the service.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }

    
}

