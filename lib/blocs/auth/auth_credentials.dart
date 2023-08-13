import 'package:flutter/foundation.dart';

class AuthCredentials {
  final String email;
  final String? username;
  final String? password;
  final String? gender;
  String? userId;

  AuthCredentials({
    required this.email,
    this.username,
    this.password,
    this.gender,
    this.userId,
  });
}
