import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:study_savvy_app/services/api_article_improver.dart';

import 'package:study_savvy_app/utils/exception.dart';

abstract class ArticleEvent {}
class ArticleEventGraph extends ArticleEvent{
  final ArticleImage article;
  ArticleEventGraph(this.article);
}
class ArticleEventText extends ArticleEvent{
  final ArticleText article;
  ArticleEventText(this.article);
}
class ArticleEventRefresh extends ArticleEvent{}

class ArticleState {
  final String status;
  final String? error;
  ArticleState(this.status,this.error);
}

class ArticleBloc extends Bloc<ArticleEvent,ArticleState> {
  ArticleBloc(): super(ArticleState("INIT",null)){
    on<ArticleEvent>((event,emit) async {
      if (event is ArticleEventRefresh){
        emit(ArticleState("INIT",null));
      }
      else if (event is ArticleEventGraph){
        emit(ArticleState("PENDING",null));
        try{
          await predictOcrGraph(event.article);
          emit(ArticleState("SUCCESS",null));  
        }
        on AuthException {
          emit(ArticleState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(ArticleState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(ArticleState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(ArticleState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(ArticleState("FAILURE","UNKNOWN"));
        }
      }
      else if (event is ArticleEventText){
        emit(ArticleState("PENDING",null));
        try{
          await predictOcrText(event.article);
          emit(ArticleState("SUCCESS",null));
        }
        on AuthException {
          emit(ArticleState("FAILURE","AUTH"));
        }
        on ServerException {
          emit(ArticleState("FAILURE","SERVER"));
        }
        on ClientException {
          emit(ArticleState("FAILURE","CLIENT"));
        }
        on ExistException {
          emit(ArticleState("FAILURE","EXIST"));
        }
        catch(e) {
          emit(ArticleState("FAILURE","UNKNOWN"));
        }
      }
      else {
        throw Exception("Error event in Article");
      }
    });
  }
}

