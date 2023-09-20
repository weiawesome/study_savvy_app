import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_state.dart';
import 'package:study_savvy_app/services/signUp_api.dart';

import '../../utils/exception.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;
  final SignUpService apiService;

  SignUpBloc({required this.authRepo, required this.authCubit, SignUpService? apiService})
     : apiService = apiService ?? SignUpService(),
     super(SignUpState()){
      on<SignUpEvent>(_onEvent);
     }

  Future<void> _onEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
    // Username updated
    if (event is SignUpUsernameChanged) {
      emit(state.copyWith(username: event.username));

      // Email updated
    } else if (event is SignUpEmailChanged) {
      emit(state.copyWith(email: event.email));

      // Password updated
    } else if (event is SignUpPasswordChanged) {
      emit(state.copyWith(password: event.password));

    } else if (event is SignUpConfirmPasswordChanged) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));

    } else if (event is SignUpGenderChanged) {
      emit(state.copyWith(gender: event.gender));

      // Form submitted
    } else if (event is SignUpSubmitted) {

        emit(SignUpState(formStatus: "PENDING"));
        try{
          await apiService!.sendEmailConfirmation(event.model);
          emit(SignUpState(formStatus: "SUCCESS"));
        }
        on ClientException {
          emit(SignUpState(formStatus: "FAILURE"));
        }
        on ExistException {
          emit(SignUpState(formStatus: "FAILURE"));
        }
        catch(e) {
          emit(SignUpState(formStatus: "FAILURE"));
        }
 
    }
  }
}