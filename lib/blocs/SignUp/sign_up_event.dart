import 'package:study_savvy_app/models/model_signup.dart';
abstract class SignUpEvent {}

class SignUpUsernameChanged extends SignUpEvent {
  final String username;

  SignUpUsernameChanged({required this.username});
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  SignUpEmailChanged({required this.email});
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpConfirmPasswordChanged extends SignUpEvent {
  final String confirmPassword;

  SignUpConfirmPasswordChanged({required this.confirmPassword});
}

class SignUpGenderChanged extends SignUpEvent {
  final String gender;

  SignUpGenderChanged({required this.gender});
}

class SignUpSubmitted extends SignUpEvent {
  final SignUpModel model;

  SignUpSubmitted({required this.model});
}
class SignUpVerify extends SignUpEvent {
  final SignUpModel model;
  final String code;

  SignUpVerify({required this.model,required this.code});
}

class SignUpEventReset extends SignUpEvent{}

