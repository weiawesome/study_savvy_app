import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/api_files.dart';
import '../models/model_files.dart';
import '../utils/exception.dart';

abstract class FilesEvent {}
class FilesEventInit extends FilesEvent{}
class FilesEventLoadMore extends FilesEvent{
  final Files files;
  FilesEventLoadMore(this.files);
}
class FilesEventRefresh extends FilesEvent{}

class FilesState {
  final String status;
  final String? error;
  final Files files;
  FilesState(this.status,this.error,this.files);
}

class FilesBloc extends Bloc<FilesEvent,FilesState> {
  FilesBloc(): super(FilesState("INIT",null,Files([],0,0))){
    on<FilesEvent>((event,emit) async {
      if (event is FilesEventInit){
        try{
          Files result=await getFiles(1);
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
          Files result=await getFiles(1);
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
        if(event.files.total_pages>event.files.current_page){
          try{
            Files result=await getFiles((event.files.current_page+1));
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
  Files combineFiles(Files original_file,Files new_file){
    return Files(original_file.files+new_file.files, new_file.current_page, new_file.total_pages);
  }
}

