import 'dart:convert';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:http/http.dart' as http;
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