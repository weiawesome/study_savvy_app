import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/screens/article_improver.dart';
import 'package:study_savvy_app/screens/files.dart';
import 'package:study_savvy_app/screens/profile.dart';

enum PageState { audio,articleImprover,files,profile }

final pageWidgets = {
  PageState.audio: Container(),
  PageState.articleImprover: const ArticleImproverPage(),
  PageState.files:const FilesPage(),
  PageState.profile:const ProfilePage(),
};
final pageIndex = {
  PageState.audio: 0,
  PageState.articleImprover: 1,
  PageState.files:2,
  PageState.profile:3,
};
final pageEvents=[PageEventAudio(),PageEventArticleImprover(),PageEventFiles(),PageEventProfile()];

abstract class PageEvent {}

class PageEventAudio extends PageEvent {}

class PageEventArticleImprover extends PageEvent {}

class PageEventFiles extends PageEvent {}

class PageEventProfile extends PageEvent {}

class PageBloc extends Bloc<PageEvent,PageState> {
  PageBloc() : super(PageState.audio){
    on<PageEvent>((event, emit) {
      if (event is PageEventArticleImprover){
        emit(PageState.articleImprover);
      } else if(event is PageEventFiles){
        emit(PageState.files);
      }else if(event is PageEventProfile){
        emit(PageState.profile);
      }
    });
  }

}
