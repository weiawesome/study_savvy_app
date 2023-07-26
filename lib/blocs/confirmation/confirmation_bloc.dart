import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/auth/auth_cubit.dart';
import 'package:study_savvy_app/blocs/auth/auth_repository.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({ 
    required this.authRepo,
    required this.authCubit,
    }) : super(ConfirmationState()) {
    on<ConfirmationEvent>(_onEvent);
  }

  Future<void> _onEvent(ConfirmationEvent event, Emitter<ConfirmationState> emit) async {
    // Confirmation code updated
    if (event is ConfirmationCodeChanged) {
      emit(state.copyWith(code: event.code));

      // Form submitted
    } else if (event is ConfirmationSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));
  
      try {
        final userId = await authRepo.confirmSignUp(    //這裡
          username: authCubit.credentials.username,
          confirmationCode: state.code,
        );
        print(userId);
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        final credentials = authCubit.credentials;
        credentials.userId = userId;              //這裡
        print(credentials);
        authCubit.launchSession(credentials);
      } catch (e) {
        print(e);
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString() as Exception)));
      }
    }
  }
}