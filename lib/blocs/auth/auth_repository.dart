import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:study_savvy_app/models/model_login.dart';
import 'package:study_savvy_app/services/login_api.dart';
class AuthRepository {

  Future<String> attemptAutoLogin() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('not signed in');
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    LoginService loginService=LoginService();
    await loginService.login(LoginModel(email, password));
    return;
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
    required String gender,
  }) async {
    print('signUp auth repo~~');
    await Future.delayed(Duration(seconds: 2));
  }

  Future<String> confirmSignUp({
    required String email,
    required String confirmationCode,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return 'userID';
  }

  Future<void> signOut() async {
    await Future.delayed(Duration(seconds: 2));
  }
}

