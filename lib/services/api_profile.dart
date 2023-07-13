import 'dart:convert';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/services/encrypt.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'api_routes.dart';
import 'jwt_storage.dart';

class ProfileService {
  JwtService jwtService;
  http.Client httpClient;

  ProfileService({JwtService? jwtService, http.Client? httpClient,}): jwtService = jwtService ?? JwtService(), httpClient = httpClient ?? http.Client();
  
  Future<Profile> getProfile() async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.get(
      Uri.parse(ApiRoutes.profileUrl),
      headers: {'Authorization': 'Bearer $jwt'},
    );
    if (response.statusCode == 200) {
      Map<String,dynamic> result=jsonDecode(response.body);
      return Profile.fromJson(result);
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

  Future<void> setApiKey(String apikey) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    SecureData data=await encrypt(apikey);
    final response = await httpClient.put(
      Uri.parse(ApiRoutes.apiKeyUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(data.formatApiKey()),
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

  Future<void> setAccessToken(String accessToken) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    SecureData data=await encrypt(accessToken);
    final response = await httpClient.put(
      Uri.parse(ApiRoutes.accessTokenUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt'
      },
      body: jsonEncode(data.formatAccessToken()),
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

  Future<void> resetPassword(UpdatePwd data) async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.put(
      Uri.parse(ApiRoutes.passwordEditUrl),
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
    else if(response.statusCode==401){
      throw PasswordException("Password's error");
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

  Future<void> logout() async {
    String? jwt=await jwtService.getJwt();
    if(jwt==null){
      throw AuthException("JWT invalid");
    }
    final response = await httpClient.delete(
      Uri.parse(ApiRoutes.logoutUrl),
      headers: {
        'Authorization': 'Bearer $jwt'
      },
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
}