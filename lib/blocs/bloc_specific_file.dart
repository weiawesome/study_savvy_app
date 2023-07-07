import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_files.dart';

import '../utils/exception.dart';

abstract class FileEvent {}
class FileEventOCR extends FileEvent{
  final String id;
  FileEventOCR(this.id);
}
class FileEventASR extends FileEvent{
  final String id;
  FileEventASR(this.id);
}
class FileEventClear extends FileEvent{}
class FileState {
  final String status;
  final String? error;
  final SpecificFile? file;
  final Uint8List? media;
  final String? type;
  FileState(this.status,this.error,this.file,this.media,this.type);
}


class FileBloc extends Bloc<FileEvent,FileState> {
  FileBloc(): super(FileState("INIT",null, null, null,null)){
    on<FileEvent>((event,emit) async {
      if (event is FileEventOCR){
        try{
          SpecificFile file=await getSpecificFile(event.id);
          Uint8List media=await getImage(event.id);
          emit(FileState("SUCCESS",null,file, media,"OCR"));  
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null));
        }
        
      }
      else if (event is FileEventASR){
        try{
          SpecificFile file=await getSpecificFile(event.id);
          Uint8List media=await getAudio(event.id);
          emit(FileState("SUCCESS",null,file, media,"ASR"));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null));
        }
      }
      else if (event is FileEventClear){
        emit(FileState("INIT",null,null,null,null));
      }
      else {
        throw Exception("Error event in specific_file");
      }
    });
  }
}