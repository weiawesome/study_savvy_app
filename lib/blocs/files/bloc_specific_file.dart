import 'dart:typed_data';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/files/model_files.dart';
import 'package:study_savvy_app/services/files/api_files.dart';
import 'package:study_savvy_app/utils/exception.dart';

abstract class FileEvent {}
class FileEventOCR extends FileEvent{
  final String id;
  FileEventOCR(this.id);
}
class FileEventASR extends FileEvent{
  final String id;
  FileEventASR(this.id);
}
class FileEventDelete extends FileEvent{
  final String id;
  FileEventDelete(this.id);
}
class FileEventEditOCR extends FileEvent{
  final EditFile file;
  FileEventEditOCR(this.file);
}
class FileEventEditASR extends FileEvent{
  final EditFile file;
  FileEventEditASR(this.file);
}
class FileEventClear extends FileEvent{}
class FileEventUnknown extends FileEvent{}

class FileState {
  final String status;
  final String? message;
  final SpecificFile? file;
  final Uint8List? media;
  final String? type;
  final String? id;
  FileState(this.status,this.message,this.file,this.media,this.type,this.id);
  @override
  String toString(){
    return "FileState $status $message $file $media $type $id";
  }
}


class FileBloc extends Bloc<FileEvent,FileState> {
  final FilesService apiService;
  FileBloc({FilesService? apiService}):apiService=apiService??FilesService(), super(FileState("INIT",null, null, null,null,null)){
    on<FileEvent>((event,emit) async {
      apiService ??= FilesService();
      if (event is FileEventOCR){
        try{
          SpecificFile file=await apiService!.getSpecificFile(event.id);
          Uint8List? media=await apiService!.getImage(event.id);
          emit(FileState("SUCCESS",null,file, media,"OCR",event.id));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null,null));
        }
      }
      else if (event is FileEventASR){
        try{
          SpecificFile file=await apiService!.getSpecificFile(event.id);
          Uint8List media=await apiService!.getAudio(event.id);
          emit(FileState("SUCCESS",null,file, media,"ASR",event.id));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null,null));
        }
      }
      else if (event is FileEventClear){
        emit(FileState("INIT",null,null,null,null,null));
      }
      else if(event is FileEventDelete){
        emit(FileState("PENDING",null,null,null,null,null));
        try{
          await apiService!.deleteSpecificFile(event.id);
          emit(FileState("SUCCESS_OTHER","Success to delete",null,null,null,null));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null,null));
        }
      }
      else if(event is FileEventEditOCR){
        emit(FileState("PENDING",null,null,null,null,null));
        try{
          await apiService!.editSpecificFileOCR(event.file);
          emit(FileState("SUCCESS_OTHER","Success to upload",null,null,null,null));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null,null));
        }
      }
      else if(event is FileEventEditASR){
        emit(FileState("PENDING",null,null,null,null,null));
        try{
          await apiService!.editSpecificFileASR(event.file);
          emit(FileState("SUCCESS_OTHER","Success to upload",null,null,null,null));
        }
        on AuthException {
          emit(FileState("FAILURE","AUTH", null, null,null,null));
        }
        on ServerException {
          emit(FileState("FAILURE","SERVER", null, null,null,null));
        }
        on ClientException {
          emit(FileState("FAILURE","CLIENT", null, null,null,null));
        }
        on ExistException {
          emit(FileState("FAILURE","EXIST", null, null,null,null));
        }
        catch(e) {
          emit(FileState("FAILURE","UNKNOWN", null, null,null,null));
        }
      }
      else {
        throw Exception("Error event in specific_file");
      }
    });
  }
}