import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:study_savvy_app/services/api_article_improver.dart';

abstract class ArticleEvent {}
class ArticleEventGraph extends ArticleEvent{
  final Article_Image article;
  ArticleEventGraph(this.article);
}
class ArticleEventText extends ArticleEvent{
  final Article_Text article;
  ArticleEventText(this.article);
}
class ArticleEventRefresh extends ArticleEvent{}

class ArticleState {
  final String status;
  ArticleState(this.status);
}

class ArticleBloc extends Bloc<ArticleEvent,ArticleState> {
  ArticleBloc(): super(ArticleState("INIT")){
    on<ArticleEvent>((event,emit) async {
      if (event is ArticleEventRefresh){
        emit(ArticleState("INIT"));
      }
      else if (event is ArticleEventGraph){
        emit(ArticleState("PENDING"));
        await predictOCR_graph(event.article.image, event.article.prompt);
        emit(ArticleState("SUCCESS"));
      }
      else {
        throw Exception("Error event in Article");
      }
    });
  }
}

