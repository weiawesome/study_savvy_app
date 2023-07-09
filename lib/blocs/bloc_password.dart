import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import '../utils/exception.dart';

abstract class PasswordEvent {}
class PasswordEventUpdate extends PasswordEvent{
  final UpdatePwd pwd;
  PasswordEventUpdate(this.pwd);
}
class PasswordEventReset extends PasswordEvent{}

class PasswordState {
  final String status;
  final String? error;
  PasswordState(this.status,this.error);
}
class PasswordBloc extends Bloc<PasswordEvent,PasswordState> {
  PasswordBloc(): super(PasswordState("INIT",null)){
    on<PasswordEvent>((event,emit) async {
      if(event is PasswordEventUpdate){
        emit(PasswordState("PENDING",null));
        try{
          await resetPassword(event.pwd);
          emit(PasswordState("SUCCESS",null));
        }
        on AuthException {
          emit(PasswordState("FAILURE","AUTH"));
        }
        on PasswordException{
          emit(PasswordState("FAILURE","PASSWORD NOT MATCH"));
        }
        on ServerException {
          emit(PasswordState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(PasswordState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(PasswordState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(PasswordState("FAILURE","UNKNOWN"));
        }

      }
      if(event is PasswordEventReset){
        emit(PasswordState("INIT",null));
      }
      else{
        throw Exception("Error event in Password_file");
      }
    });
  }
}