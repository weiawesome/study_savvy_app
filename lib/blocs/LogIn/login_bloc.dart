import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/LogIn/login_state.dart';
import 'package:study_savvy_app/blocs/LogIn/login_event.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import '../auth/auth_credentials.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginEmailChanged) {
      emit(state.copyWith(email: event.email));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    // form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        debugPrint("test");
        final userId = await authRepo.login(  //這裡
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        authCubit.launchSession(AuthCredentials(
          email: state.email,
          userId: userId,   //這裡
        ));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString() as Exception)));
      }
    }
  }
}