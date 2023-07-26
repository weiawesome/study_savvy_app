import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
     : super(SignUpState()){
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

      // Form submitted
    } else if (event is SignUpSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.signUp(
          username: state.username,
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        authCubit.showConfirmSignUp( 
          username: state.username,
          email: state.email,
          password: state.password,
        );
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString() as Exception)));
      }
    }
  }
}