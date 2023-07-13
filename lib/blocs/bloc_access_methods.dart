import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/utils/exception.dart';
import 'package:study_savvy_app/services/api_profile.dart';

abstract class AccessMethodEvent {}

class AccessMethodEventReset extends AccessMethodEvent{}

class AccessMethodEventApiKey extends AccessMethodEvent{
  final String apikey;
  AccessMethodEventApiKey(this.apikey);
}
class AccessMethodEventAccessToken extends AccessMethodEvent{
  final String accessToken;
  AccessMethodEventAccessToken(this.accessToken);
}

class AccessMethodState {
  final String status;
  final String? error;
  AccessMethodState(this.status,this.error);
}
class AccessMethodBloc extends Bloc<AccessMethodEvent,AccessMethodState?> {
  final ProfileService apiService;
  AccessMethodBloc({ProfileService? apiService})
      : apiService = apiService ?? ProfileService(), super(null){
    on<AccessMethodEvent>((event,emit) async {
      if(event is AccessMethodEventReset){
        emit(null);
      }
      else if(event is AccessMethodEventApiKey){
        emit(AccessMethodState("PENDING",null));
        try{
          await apiService!.setApiKey(event.apikey);
          emit(AccessMethodState("SUCCESS",null));
        }
        on AuthException {
          emit(AccessMethodState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(AccessMethodState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(AccessMethodState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(AccessMethodState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(AccessMethodState("FAILURE","UNKNOWN"));
        }
      }
      else if(event is AccessMethodEventAccessToken){
        emit(AccessMethodState("PENDING",null));
        try{
          await apiService!.setAccessToken(event.accessToken);
          emit(AccessMethodState("SUCCESS",null));
        }
        on AuthException {
          emit(AccessMethodState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(AccessMethodState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(AccessMethodState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(AccessMethodState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(AccessMethodState("FAILURE","UNKNOWN"));
        }
      }
      else{
        throw Exception("Error event in Access_method_file");
      }
    });
  }
}