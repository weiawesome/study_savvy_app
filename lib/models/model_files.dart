class File {
  final String id;
  final String time;
  final String status;
  final String type;
  File(this.id,this.type,this.status,this.time);
}
class Files{
  final List<dynamic> files;
  final int currentPage;
  final int totalPages;
  Files(this.files,this.currentPage,this.totalPages);
  Files.fromJson(Map<String, dynamic> json) :
        files=(json['datas']).map((item){
          return File(item['file_id'],item["file_type"],item["status"],item["file_time"]);
        }).toList(),
        currentPage=json['current_page'],
        totalPages=json['total_pages'];
}

class SpecificFile{
  final String content;
  final String prompt;
  final String summarize;
  final List<dynamic> details;
  SpecificFile(this.content,this.prompt,this.summarize,this.details);
  SpecificFile.fromJson(Map<String, dynamic> json) :
        content = json['content'] as String,
        prompt =json['prompt'] as String,
        summarize =json['summarize'] as String,
        details =json['details'];
}

class EditFile{
  final String id;
  final String prompt;
  final String content;
  EditFile(this.id,this.prompt,this.content);
  Map<String,String> formatJson(){
    return {"prompt":prompt,"content":content};
  }
}
