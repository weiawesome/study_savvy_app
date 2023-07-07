import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/utils/exception.dart';
import '../services/api_profile.dart';

abstract class Access_methodEvent {}

class Access_methodEventReset extends Access_methodEvent{}

class Access_methodEventApiKey extends Access_methodEvent{
  final String apikey;
  Access_methodEventApiKey(this.apikey);
}
class Access_methodEventAccessToken extends Access_methodEvent{
  final String accesstoken;
  Access_methodEventAccessToken(this.accesstoken);
}

class Access_methodState {
  final String status;
  final String? error;
  Access_methodState(this.status,this.error);
}
class Access_methodBloc extends Bloc<Access_methodEvent,Access_methodState?> {
  Access_methodBloc(): super(null){
    on<Access_methodEvent>((event,emit) async {
      if(event is Access_methodEventReset){
        emit(null);
      }
      else if(event is Access_methodEventApiKey){
        emit(Access_methodState("PENDING",null));
        try{
          await setApiKey(event.apikey);
          emit(Access_methodState("SUCCESS",null));
        }
        on AuthException {
          emit(Access_methodState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(Access_methodState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(Access_methodState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(Access_methodState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(Access_methodState("FAILURE","UNKNOWN"));
        }
      }
      else if(event is Access_methodEventAccessToken){
        emit(Access_methodState("PENDING",null));
        try{
          await setAccessToken(event.accesstoken);
          emit(Access_methodState("SUCCESS",null));
        }
        on AuthException {
          emit(Access_methodState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(Access_methodState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(Access_methodState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(Access_methodState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(Access_methodState("FAILURE","UNKNOWN"));
        }
      }
      else{
        throw Exception("Error event in Access_method_file");
      }
    });
  }
}