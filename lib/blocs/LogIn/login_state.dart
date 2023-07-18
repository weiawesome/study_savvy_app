import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';

class LoginState {
  final String email;
  bool get isValidEmail => email.length > 3;  //之後改是否包含"@"

  final String password;
  bool get isValidPassword => password.length >= 8;

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