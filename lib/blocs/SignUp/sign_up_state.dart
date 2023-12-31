
class SignUpState {
  final String username;
  bool get isValidUsername => username.length >= 3;

  final String email;
  bool get isValidEmail => email.contains('@');

  final String password;
  bool get isValidPassword => password.length >= 8;

  final String confirmPassword;
  bool get isValidConfirmPassword => (password == confirmPassword) ;

  final String gender;

  final String formStatus;

  SignUpState( {
    this.username = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.gender = '',
    this.formStatus = '',
  });

  SignUpState copyWith({
    String? username,
    String? email,
    String? password,
    String? confirmPassword,
    String? gender,
    String? formStatus,
  }) {
    return SignUpState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}