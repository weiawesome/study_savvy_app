import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';

class audioState {
  final String status;
  final String? error;
  audioState(this.status, this.error);

  @override
  String toString(){
    return "audioState $status $error";
  }
}