class File {
  final String id;
  final String time;
  final String status;
  final String type;
  File(this.id,this.type,this.status,this.time);

}
class Files{
  final List<File> files;
  final BigInt page;
  final BigInt total_pages;
  Files(this.files,this.page,this.total_pages);
}
class File_Info{
  final String id;
  final String type;
  File_Info(this.id,this.type);
}

class Specific_File{
  final String content;
  final String prompt;
  final String summarize;
  final List<String> details;
  Specific_File(this.content,this.prompt,this.summarize,this.details);
}
