import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/profile/api_profile.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/exception.dart';

abstract class OnlineEvent {}
class OnlineEventLogout extends OnlineEvent{}
class OnlineEventCheck extends OnlineEvent{}
class OnlineEventReset extends OnlineEvent{
  final bool? status;
  OnlineEventReset(this.status);
}
class OnlineEventUnknown extends OnlineEvent{}

class OnlineState {
  final bool? status;
  final String? message;
  OnlineState(this.status,this.message);
  @override
  String toString(){
    return "OnlineState $status $message";
  }
}

class OnlineBloc extends Bloc<OnlineEvent,OnlineState> {
  final ProfileService apiService;
  final JwtService jwtService;
  OnlineBloc({ProfileService? apiService,JwtService? jwtService}):apiService=apiService??ProfileService(),jwtService=jwtService??JwtService(), super(OnlineState(true,null)){
    on<OnlineEvent>((event,emit) async {
      if(event is OnlineEventLogout){
        emit(OnlineState(null,null));
        try{
          await apiService!.logout();
          await jwtService!.deleteJwt();
          emit(OnlineState(false,null));
        }
        on AuthException {
          await jwtService!.deleteJwt();
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
        bool? status=await jwtService!.hasJwt();
        emit(OnlineState(status==true,null));
      }
      else{
        throw Exception("message event in Online_file");
      }
    });
  }
}