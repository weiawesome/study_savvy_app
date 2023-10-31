import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:study_savvy_app/models/model_login.dart';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/utils/exception.dart';
import './api_routes.dart';
import './utils/jwt_storage.dart';

class LoginService {
  JwtService jwtService;
  http.Client httpClient;

  LoginService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();

  Future<void> login(LoginModel data) async {
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.logInUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept':'application/json',
      },
      body: jsonEncode(data.formatJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('token')) {
        String token = responseBody['token'];
        debugPrint(responseBody['token']);
        debugPrint("/n Login successfully! /n");
        await jwtService.saveJwt(token);
      } else {
        throw AuthException("Token not found in response");
      }
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Invalid status value. RequestBody is not match request.");
    }
    else if (response.statusCode == 401){
      await jwtService.deleteJwt();
      throw AuthException("Unauthorized with information. User have not registered or with incorrect password.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }
}