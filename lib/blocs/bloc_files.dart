import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/services/api_files.dart';
import '../models/model_files.dart';

abstract class FilesEvent {}
class FilesEventInit extends FilesEvent{}
class FilesEventLoadMore extends FilesEvent{
  final Files files;
  FilesEventLoadMore(this.files);
}
class FilesEventRefresh extends FilesEvent{}

class FilesState {
  final Files files;
  FilesState(this.files);
}

class FilesBloc extends Bloc<FilesEvent,FilesState> {
  FilesBloc(): super(FilesState(Files([],0,0))){
    on<FilesEvent>((event,emit) async {
      if (event is FilesEventInit){

        Files result=await getFiles(1);
        emit(FilesState(result));
        print(result);
      }
      else if (event is FilesEventRefresh){
        Files result=await getFiles(1);
        emit(FilesState(result));
      }
      else if (event is FilesEventLoadMore){
        if(event.files.total_pages>event.files.current_page){
          Files result=await getFiles((event.files.current_page+1));
          emit(FilesState(combineFiles(event.files, result)));
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

