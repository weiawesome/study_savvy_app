class File {
  final String id;
  final String time;
  final String status;
  final String type;
  File(this.id,this.type,this.status,this.time);
}
class Files{
  final List<dynamic> files;
  final int current_page;
  final int total_pages;
  Files(this.files,this.current_page,this.total_pages);
  Files.fromJson(Map<String, dynamic> json) :
        files=(json['datas']).map((item){
          return File(item['file_id'],item["file_type"],item["status"],item["file_time"]);
        }).toList(),
        current_page=json['current_page'],
        total_pages=json['total_pages'];
}

class Specific_File{
  final String content;
  final String prompt;
  final String summarize;
  final List<dynamic> details;
  Specific_File(this.content,this.prompt,this.summarize,this.details);
  Specific_File.fromJson(Map<String, dynamic> json) :
        content = json['content'] as String,
        prompt =json['prompt'] as String,
        summarize =json['summarize'] as String,
        details =json['details'];
}
