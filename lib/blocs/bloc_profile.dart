import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:study_savvy_app/services/api_profile.dart';

import '../utils/exception.dart';

abstract class ProfileEvent {}
class ProfileEventGet extends ProfileEvent{}
class ProfileEventReset extends ProfileEvent{}

class ProfileState {
  final String status;
  final String? error;
  final Profile profile;
  ProfileState(this.status,this.error,this.profile);
}
class ProfileBloc extends Bloc<ProfileEvent,ProfileState> {
  ProfileBloc(): super(ProfileState("INIT",null,Profile("","",""))){
    on<ProfileEvent>((event,emit) async {
      if(event is ProfileEventGet){
        try{
          Profile result=await getProfile();
          emit(ProfileState("SUCCESS",null, result));  
        }
        on AuthException {
          emit(ProfileState("FAILURE","AUTH",Profile("","","")));
        }
        on ServerException {
          emit(ProfileState("FAILURE","SERVER",Profile("","","")));
        }
        on ClientException {
          emit(ProfileState("FAILURE","CLIENT",Profile("","","")));
        }
        on ExistException {
          emit(ProfileState("FAILURE","EXIST",Profile("","","")));
        }
        catch(e) {
          emit(ProfileState("FAILURE","UNKNOWN",Profile("","","")));
        }
        
      }
      else if(event is ProfileEventReset){
        emit(ProfileState("INIT",null,Profile("","","")));
      }
      else{
        throw Exception("Error event in profile_file");
      }
    });
  }
}