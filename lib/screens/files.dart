import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_files.dart';
import 'package:study_savvy_app/blocs/bloc_specific_file.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import '../styles/custom_style.dart';

class FilesPage extends StatefulWidget{
  const FilesPage({Key?key}):super(key: key);
  @override
  State<FilesPage> createState()=> _FilesPage();
}

class _FilesPage extends State<FilesPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    context.read<FilesBloc>().add(FilesEventInit());
    _scrollController.addListener(() {
      FilesState? state=context.read<FilesBloc>().state;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<FilesBloc>().add(FilesEventLoadMore(state.files));
      }
    });
  }

  Future<void> _refresh() async {
    return context.read<FilesBloc>().add(FilesEventRefresh());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text('Files',style: Theme.of(context).textTheme.bodyLarge),
            ),
          ),
          Expanded(
              flex: 9,
              child: BlocBuilder<FilesBloc,FilesState>(
                builder: (context,state){
                  if(state.status=="INIT"){
                    return const Loading();
                  }
                  else if (state.status=="SUCCESS" || state.status=="PENDING"){
                    return RefreshIndicator(
                      color: Theme.of(context).hintColor,
                      onRefresh: _refresh,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          itemCount: state.files.files.length,
                          itemBuilder: (context, index) {
                            return TextButton(
                                onPressed: (){
                                  if ((state.files.files[index]).status=='SUCCESS'){
                                    Navigator.pushNamed(context, Routes.specificFile);
                                    if((state.files.files[index]).type=="OCR"){
                                      context.read<FileBloc>().add(FileEventOCR((state.files.files[index]).id));
                                    }
                                    else if((state.files.files[index]).type=="ASR"){
                                      context.read<FileBloc>().add(FileEventASR((state.files.files[index]).id));
                                    }
                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('錯誤'),
                                          content: const Text('這份檔案正在執行或失敗\n目前無法開啟'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('确定'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );

                                  }

                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return Theme.of(context).hintColor;
                                      }
                                      // 其他状态下的背景色
                                      return Colors.transparent;
                                    },
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(width: 1),color:Theme.of(context).brightness == Brightness.dark ? DarkStyle.fileBoxColor:LightStyle.fileBoxColor),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex:2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Title',style: Theme.of(context).textTheme.bodySmall,),
                                            Text('Type',style: Theme.of(context).textTheme.bodySmall,),
                                            Text('Date_Time',style: Theme.of(context).textTheme.bodySmall,),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex:3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('',style: Theme.of(context).textTheme.bodySmall,),
                                            Text((state.files.files[index]).type,style: Theme.of(context).textTheme.titleSmall,),
                                            Text((state.files.files[index]).time.toString(),style: Theme.of(context).textTheme.titleSmall,),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                          children:
                                          (state.files.files[index]).status=='SUCCESS'?
                                          [const Icon(Icons.check_circle_outline,color: Color.fromRGBO(48,219,91,1),size: 45,),Text('OK',style: Theme.of(context).textTheme.bodySmall,)] :
                                          (state.files.files[index]).status=='FAILURE'?
                                          [const Icon(Icons.dangerous_sharp,color: Colors.red,size: 45,),Text('Fail',style: Theme.of(context).textTheme.bodySmall,)]:
                                          [Icon(Icons.query_stats_rounded,color: Colors.yellow[900],size: 45,),Text('Wait',style: Theme.of(context).textTheme.bodySmall,)],

                                        ),
                                      )
                                    ],

                                  ),
                                ));
                          }
                      ),
                    );
                  }
                  else{
                    return Failure(error: state.error!);
                  }
                },
              ),
          ),
        ]
    );
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}