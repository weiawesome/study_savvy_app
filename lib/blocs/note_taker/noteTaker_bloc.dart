import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/note_taker/noteTaker_event.dart';
import 'package:study_savvy_app/blocs/note_taker/noteTaker_state.dart';
import 'package:study_savvy_app/blocs/auth/form_submission_status.dart';
import 'package:study_savvy_app/services/note_taker.dart';
import 'package:flutter/material.dart';
import 'package:study_savvy_app/utils/exception.dart';

class audioBloc extends Bloc<audioEvent, audioState> {
  final noteTaker_Service apiService;
  audioBloc({noteTaker_Service? apiService}):apiService = apiService ?? noteTaker_Service(), super(audioState("INIT",null)){
    on<audioEvent>((event,emit) async {
      apiService ??= noteTaker_Service();
      if (event is audioEventRefresh){
        emit(audioState("INIT",null));
      }
      else if (event is audioChanged){
        emit(audioState("PENDING",null));
        try{
          await apiService!.predictASR(event.note);
          emit(audioState("SUCCESS",null));  
        }
        on AuthException {
          emit(audioState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(audioState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(audioState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(audioState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(audioState("FAILURE","UNKNOWN"));
        }
      }
      else {
        throw Exception("Error event in Article");
      }
    });
  }
}

