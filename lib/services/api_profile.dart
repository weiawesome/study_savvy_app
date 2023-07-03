import 'dart:convert';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:http/http.dart' as http;
import 'package:study_savvy_app/services/encrypt.dart';
import 'api_routes.dart';
import 'jwt_storage.dart';

Future<Profile> getProfile() async {
  String? jwt=await JwtService.getJwt();
  final response = await http.get(
    Uri.parse(API_Routes.Profile_url),
    headers: {'Authorization': 'Bearer '+jwt!},
  );
  if (response.statusCode == 200) {
    Map<String,dynamic> result=jsonDecode(response.body);
    return Profile.fromJson(result);
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    throw Exception('Failed to load Profile');
  }
  else{
    throw Exception('Failed to load Profile');
  }
}

Future<void> setApiKey(String apikey) async {
  String? jwt=await JwtService.getJwt();
  SecureData data=await encrypt(apikey);
  final response = await http.put(
    Uri.parse(API_Routes.Api_Key_url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+jwt!
    },
    body: jsonEncode(data.formatApiKey()),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return ;
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    throw Exception('Failed to set apikey');
  }
  else{
    throw Exception('Failed to set apikey');
  }
}

Future<void> setAccessToken(String accesstoken) async {
  String? jwt=await JwtService.getJwt();
  SecureData data=await encrypt(accesstoken);
  final response = await http.put(
    Uri.parse(API_Routes.Access_Token_url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+jwt!
    },
    body: jsonEncode(data.formatAccessToken()),
  );
  if (response.statusCode == 200) {
    return ;
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    throw Exception('Failed to set apikey');
  }
  else{
    throw Exception('Failed to set apikey');
  }
}