import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:study_savvy_app/blocs/bloc_files.dart';
import 'package:study_savvy_app/blocs/bloc_specific_file.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/widgets/success.dart';
import 'package:study_savvy_app/styles/custom_style.dart';

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
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<FilesBloc>().add(FilesEventLoadMore(state.files));
      }
    });
  }

  Future<void> _refresh() async {
    context.read<FilesBloc>().add(FilesEventRefresh());
    return await Future.delayed(const Duration(seconds: 2));
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
                    return LiquidPullToRefresh(
                      animSpeedFactor:1.5,
                      color: Theme.of(context).hintColor,
                      onRefresh: _refresh,
                      showChildOpacityTransition: false,
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          itemCount: state.status=="PENDING"?state.files.files.length+1:state.files.files.length,
                          itemBuilder: (context, index) {
                            if(index==state.files.files.length){
                              return const Loading();
                            }
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
                                  else if((state.files.files[index]).status=='FAILURE'){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BlocBuilder<FileBloc,FileState>(
                                            builder: (context,stateFile){
                                              if(stateFile.status=="INIT"){
                                                return AlertDialog(
                                                  title: const Text('刪除錯誤檔案'),
                                                  content: const Text('這份檔案執行失敗\n目前無法開啟，是否刪除?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: const Text('取消'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: const Text('刪除'),
                                                      onPressed: () {
                                                        context.read<FileBloc>().add(FileEventDelete((state.files.files[index]).id));
                                                      },
                                                    ),
                                                  ],
                                                );
                                              }
                                              else if(stateFile.status=="PENDING"){
                                                return const AlertDialog(
                                                  title: Text('刪除錯誤檔案'),
                                                  content: Loading()
                                                );
                                              }
                                              else if(stateFile.status=="FAILURE"){
                                                return AlertDialog(
                                                  title: const Text('刪除錯誤檔案'),
                                                  content: Failure(error: stateFile.message!),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('確定'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ]
                                                );
                                              }
                                              else if(stateFile.status=='SUCCESS_OTHER'){
                                                return AlertDialog(
                                                  title: const Text('刪除錯誤檔案'),
                                                  content: Success(message: stateFile.message!),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text('確定'),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                    ),
                                                  ]
                                                );
                                              }
                                              else{
                                                return Container();
                                              }
                                        });
                                      },
                                    ).then((value) => {
                                      context.read<FileBloc>().add(FileEventClear())
                                    });
                                  }
                                  else{
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('錯誤'),
                                          content: const Text('這份檔案正在執行\n目前無法開啟'),
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
                                      return Colors.transparent;
                                    },
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor)),
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
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 5),
                                          decoration: BoxDecoration(border: Border(left: BorderSide(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children:
                                            (state.files.files[index]).status=='SUCCESS'?
                                            [const Icon(Icons.check_circle_outline,color: Color.fromRGBO(48,219,91,1),size: 45,),Text('OK',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,)] :
                                            (state.files.files[index]).status=='FAILURE'?
                                            [const Icon(Icons.dangerous_sharp,color: Colors.red,size: 45,),Text('Fail',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,)]:
                                            [Icon(Icons.query_stats_rounded,color: Colors.yellow[900],size: 45,),Text('Wait',style: Theme.of(context).textTheme.bodySmall,textAlign: TextAlign.center,)],

                                          ),
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