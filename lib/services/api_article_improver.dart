import 'dart:io';
import 'dart:typed_data';
import 'api_routes.dart';
import 'jwt_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<void> predictOCR_graph(File imageData, String text) async {
  String? jwt=await JwtService.getJwt();
  print(API_Routes.Article_Improver_url);
  final response = await (http.MultipartRequest(
    'POST',
    Uri.parse(API_Routes.Article_Improver_url),
  )
    ..fields['prompt']=text
    ..files.add(await http.MultipartFile.fromPath(
      'file',
      imageData.path,
      contentType: MediaType('image', 'jpeg'),
    ))
    ..headers.addAll(
    {
      'accept': '*/*',
      'Authorization': 'Bearer '+jwt!
    },
  )).send();
  print(response.statusCode);
  if (response.statusCode == 200) {
    return ;
  } else if (response.statusCode == 422){
    await JwtService.deleteJwt();
    throw Exception('Failed to load image');
  }
  else{
    throw Exception('Failed to load image');
  }
}