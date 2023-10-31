import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/LogIn/login_state.dart';
import 'package:study_savvy_app/blocs/LogIn/login_event.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/models/model_login.dart';
import 'package:study_savvy_app/services/login_api.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginService apiService=LoginService();
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
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        await apiService.login(LoginModel(state.email, state.password));
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch(e){
        emit(state.copyWith(formStatus: SubmissionFailed(Exception(e.toString()))));
      }
    }
    else if (event is LoginCancel) {
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }
}