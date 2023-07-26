import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_credentials.dart';
import 'package:study_savvy_app/blocs/session/session_cubit.dart';

enum AuthState { login, signUp, confirmSignUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  late AuthCredentials credentials;

  void showLogin() => emit(AuthState.login);
  //void showSignUp() => emit(AuthState.signUp);
  void showConfirmSignUp({
    required String username,
    required String email,
    required String password,
  }) {
    credentials = AuthCredentials(  //crate right here, to hand on argument
      username: username,
      email: email,
      password: password,
    );
    emit(AuthState.confirmSignUp); //show confirm view
  }

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
