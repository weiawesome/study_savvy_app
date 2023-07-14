import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/profile/model_profile.dart';
import 'package:study_savvy_app/services/profile/api_profile.dart';
import 'package:study_savvy_app/utils/exception.dart';

abstract class ProfileEvent {}
class ProfileEventGet extends ProfileEvent{}
class ProfileEventReset extends ProfileEvent{}
class ProfileEventUnknown extends ProfileEvent{}

class ProfileState {
  final String status;
  final String? error;
  final Profile profile;
  ProfileState(this.status,this.error,this.profile);
  @override
  String toString(){
    return "ProfileState $status $error $profile";
  }
}
class ProfileBloc extends Bloc<ProfileEvent,ProfileState> {
  final ProfileService apiService;
  ProfileBloc({ProfileService? apiService}):apiService=apiService??ProfileService(), super(ProfileState("INIT",null,Profile("","",""))){
    on<ProfileEvent>((event,emit) async {
      if(event is ProfileEventGet){
        try{
          Profile result=await apiService!.getProfile();
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