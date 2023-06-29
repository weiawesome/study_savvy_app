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
