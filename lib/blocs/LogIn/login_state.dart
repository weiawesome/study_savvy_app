import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';

class LoginState {
  final String email;
  bool get isValidEmail => email.contains("@");

  final String password;
  bool get isValidPassword => password.length >= 8 && password.length<=30 && !password.contains(' ');

  final FormSubmissionStatus formStatus;

  LoginState({
    this.email = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionStatus? formStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}