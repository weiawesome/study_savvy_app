import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({required this.email});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {
  LoginSubmitted();
}