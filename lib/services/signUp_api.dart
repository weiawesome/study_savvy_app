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

  Future<void> signUp(SignUpModel data) async {
    
    final response = await httpClient.post(
      Uri.parse(ApiRoutes.signUpUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data.formatJson()),
    );
    if (response.statusCode == 200) {

      final emailConfirmationResult = await sendEmailConfirmation(data.mail);

      if (emailConfirmationResult) {
        // 确认电子邮件发送成功，可以执行其他操作，如跳转到登录页面
        // 你可以使用路由导航或其他方式来跳转
        // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        throw Exception("Failed to send email confirmation");
      }
      
      return ;
    }
    else if(response.statusCode == 400){
      throw ClientException("Client's error");
    }
    else if(response.statusCode == 401){
      throw ExistException("Unauthorized with information. User have been signup for the service.");
    }
    else{
      throw Exception('Failed in unknown reason');
    }
  }


    Future<bool> sendEmailConfirmation(String mail) async {
    // 在这里实现发送电子邮件确认的逻辑，包括生成验证码等
    // 如果发送成功，返回 true；否则返回 false
    return true; // 示例中总是返回 true，需要根据实际情况来实现
  }
}

