import 'package:flutter/material.dart';
import 'package:study_savvy_app/screens/access_token.dart';
import 'package:study_savvy_app/screens/api_key.dart';
import 'package:study_savvy_app/screens/home.dart';
import 'package:study_savvy_app/screens/information_setting.dart';
import 'package:study_savvy_app/screens/password_setting.dart';
import 'package:study_savvy_app/screens/specific_file.dart';

class Routes {
  static const home='/home';
  static const information='/information';
  static const password='/password';
  static const apikey='/api_key';
  static const accessToken='/access_token';
  static const specificFile='/specificfile';
}
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.information:
        return MaterialPageRoute(builder: (_) => const InformationPage());
      case Routes.password:
        return MaterialPageRoute(builder: (_) => const PasswordPage());
      case Routes.apikey:
        return MaterialPageRoute(builder: (_) => const ApiKeyPage());
      case Routes.accessToken:
        return MaterialPageRoute(builder: (_) => const AccessTokenPage());
      case Routes.specificFile:
        return MaterialPageRoute(builder: (_) => const SpecificFilePage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}