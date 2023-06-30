import 'package:flutter/material.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/screens/ACCESS_TOKEN.dart';
import 'package:study_savvy_app/screens/API_KEY.dart';
import 'package:study_savvy_app/screens/Home.dart';
import 'package:study_savvy_app/screens/Information.dart';
import 'package:study_savvy_app/screens/Password.dart';
import 'package:study_savvy_app/screens/specific_file.dart';

class Routes {
  static const Home='/home';
  static const Information='/information';
  static const Password='/password';
  static const API_KEY='/api_key';
  static const ACCESS_TOKEN='/access_token';
  static const SpecificFile='/specificfile';
}
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Routes.Information:
        return MaterialPageRoute(builder: (_) => InformationPage());
      case Routes.Password:
        return MaterialPageRoute(builder: (_) => PasswordPage());
      case Routes.API_KEY:
        return MaterialPageRoute(builder: (_) => API_KEYPage());
      case Routes.ACCESS_TOKEN:
        return MaterialPageRoute(builder: (_) => ACCESS_TOKENPage());
      case Routes.SpecificFile:
        final args = settings.arguments as File_Info;
        return MaterialPageRoute(builder: (_) => SpecificFilePage(fileInfo: args));
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}