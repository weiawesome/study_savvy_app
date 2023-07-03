import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_profile.dart';
import 'package:study_savvy_app/services/api_profile.dart';

abstract class ProfileEvent {}
class ProfileEventGet extends ProfileEvent{}

class ProfileState {
  final bool status;
  final Profile profile;
  ProfileState(this.status,this.profile);
}
class ProfileBloc extends Bloc<ProfileEvent,ProfileState> {
  ProfileBloc(): super(ProfileState(false,Profile("","",""))){
    on<ProfileEvent>((event,emit) async {
      if(event is ProfileEventGet){
        Profile result=await getProfile();
        emit(ProfileState(true, result));
      }
      else{
        throw Exception("Error event in profile_file");
      }
    });
  }
}