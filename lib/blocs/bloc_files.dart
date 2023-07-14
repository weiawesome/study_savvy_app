import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/api_files.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/utils/exception.dart';

abstract class FilesEvent {}
class FilesEventInit extends FilesEvent{}
class FilesEventLoadMore extends FilesEvent{
  final Files files;
  FilesEventLoadMore(this.files);
}
class FilesEventRefresh extends FilesEvent{}
class FilesEventUnknown extends FilesEvent{}

class FilesState {
  final String status;
  final String? error;
  final Files files;
  FilesState(this.status,this.error,this.files);

  @override
  String toString(){
    return "FilesState $status $error $files";
  }
}

class FilesBloc extends Bloc<FilesEvent,FilesState> {
  final FilesService apiService;
  FilesBloc({FilesService? apiService}):apiService=apiService??FilesService(), super(FilesState("INIT",null,Files([],0,0))){
    on<FilesEvent>((event,emit) async {
      if (event is FilesEventInit){
        try{
          Files result=await apiService!.getFiles(1);
          emit(FilesState("SUCCESS",null,result));  
        }
        on AuthException {
          emit(FilesState("FAILURE","AUTH",Files([],0,0)));
        }
        on ServerException {
          emit(FilesState("FAILURE","SERVER", Files([],0,0)));
        }
        on ClientException {
          emit(FilesState("FAILURE","CLIENT",Files([],0,0)));
        }
        on ExistException {
          emit(FilesState("FAILURE","EXIST",Files([],0,0)));
        }
        catch(e) {
          emit(FilesState("FAILURE","UNKNOWN",Files([],0,0)));
        }
        
      }
      else if (event is FilesEventRefresh){
        try{
          Files result=await apiService!.getFiles(1);
          emit(FilesState("SUCCESS",null,result));
        }
        on AuthException {
          emit(FilesState("FAILURE","AUTH",Files([],0,0)));
        }
        on ServerException {
          emit(FilesState("FAILURE","SERVER", Files([],0,0)));
        }
        on ClientException {
          emit(FilesState("FAILURE","CLIENT",Files([],0,0)));
        }
        on ExistException {
          emit(FilesState("FAILURE","EXIST",Files([],0,0)));
        }
        catch(e) {
          emit(FilesState("FAILURE","UNKNOWN",Files([],0,0)));
        }
      }
      else if (event is FilesEventLoadMore){
        emit(FilesState("PENDING",null,event.files));
        if(event.files.totalPages>event.files.currentPage){
          try{
            Files result=await apiService!.getFiles((event.files.currentPage+1));
            emit(FilesState("SUCCESS",null,combineFiles(event.files, result)));
          }
          on AuthException {
            emit(FilesState("FAILURE","AUTH",Files([],0,0)));
          }
          on ServerException {
            emit(FilesState("FAILURE","SERVER", Files([],0,0)));
          }
          on ClientException {
            emit(FilesState("FAILURE","CLIENT",Files([],0,0)));
          }
          on ExistException {
            emit(FilesState("FAILURE","EXIST",Files([],0,0)));
          }
          catch(e) {
            emit(FilesState("FAILURE","UNKNOWN",Files([],0,0)));
          }
        }
        else{
          emit(FilesState("SUCCESS",null,event.files));
        }
      }
      else {
        throw Exception("Error event in files");
      }
    });
  }
  Files combineFiles(Files originalFile,Files newFile){
    return Files(originalFile.files+newFile.files, newFile.currentPage, newFile.totalPages);
  }
}

