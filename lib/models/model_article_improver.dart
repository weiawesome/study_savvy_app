import 'dart:io';

class Article_Image {
  final File image;
  final String prompt;
  Article_Image(this.image, this.prompt);
}
class Article_Text {
  final String content;
  final String prompt;
  Article_Text(this.content, this.prompt);
}