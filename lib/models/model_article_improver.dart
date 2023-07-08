import 'dart:io';

class ArticleImage {
  final File image;
  final String prompt;
  ArticleImage(this.image, this.prompt);
}
class ArticleText {
  final String content;
  final String prompt;
  ArticleText(this.content, this.prompt);
  Map<String,String> formatJson(){
    return {
      "content":content,
      "prompt":prompt
    };
  }
}