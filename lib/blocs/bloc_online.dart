import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/api_profile.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';

abstract class OnlineEvent {}
class OnlineEventLogout extends OnlineEvent{}
class OnlineEventCheck extends OnlineEvent{}
class OnlineEventReset extends OnlineEvent{
  final bool? status;
  OnlineEventReset(this.status);
}

class OnlineState {
  final bool? status;
  final String? message;
  OnlineState(this.status,this.message);
}

class OnlineBloc extends Bloc<OnlineEvent,OnlineState> {
  final ProfileService apiService=ProfileService();
  final JwtService jwtService=JwtService();
  OnlineBloc(): super(OnlineState(true,null)){
    on<OnlineEvent>((event,emit) async {
      if(event is OnlineEventLogout){
        emit(OnlineState(null,null));
        try{
          await apiService.logout();
          await jwtService.deleteJwt();
          emit(OnlineState(false,null));
        }
        on AuthException {
          await jwtService.deleteJwt();
          emit(OnlineState(false,"AUTH"));
        }
        on ServerException {
          emit(OnlineState(true,"SERVER"));
        }
        on ClientException {
          emit(OnlineState(true,"CLIENT"));
        }
        on ExistException {
          emit(OnlineState(true,"EXIST"));
        }
        catch(e) {
          emit(OnlineState(true,"UNKNOWN"));
        }
      }
      else if(event is OnlineEventReset){
        if(event.status==true){
          emit(OnlineState(true,null));
        }
        else if(event.status==false){
          throw Exception("Offline can't logout.");
        }
        else{
          throw Exception("In process of logout");
        }
      }
      else if(event is OnlineEventCheck){
        bool? status=await jwtService.hasJwt();
        emit(OnlineState(status==true,null));
      }
      else{
        throw Exception("message event in Online_file");
      }
    });
  }
}