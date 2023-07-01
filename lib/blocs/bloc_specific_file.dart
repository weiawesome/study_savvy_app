import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/api_files.dart';

abstract class FileEvent {}
class FileEventOCR extends FileEvent{
  final String ID;
  FileEventOCR(this.ID);
}
class FileEventASR extends FileEvent{
  final String ID;
  FileEventASR(this.ID);
}
class FileEventClear extends FileEvent{}
class FileState {
  final bool status;
  final Specific_File? file;
  final Uint8List? media;
  final String? type;
  FileState(this.status,this.file,this.media,this.type);
}


class FileBloc extends Bloc<FileEvent,FileState> {
  FileBloc(): super(FileState(false, null, null,null)){
    on<FileEvent>((event,emit) async {
      if (event is FileEventOCR){
        Specific_File file=await getSpecificFile(event.ID);
        Uint8List media=await getImage(event.ID);
        emit(FileState(true,file, media,"OCR"));
      }
      else if (event is FileEventASR){
        Specific_File file=await getSpecificFile(event.ID);
        Uint8List media=await getAudio(event.ID);
        emit(FileState(true,file, media,"ASR"));
      }
      else if (event is FileEventClear){
        emit(FileState(false,null,null,null));
      }
      else {
        throw Exception("Error event in specific_file");
      }
    });
  }
}