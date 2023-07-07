import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/bloc_article_improver.dart';
import 'package:study_savvy_app/models/model_article_improver.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import '../blocs/provider/ocrimage_provider.dart';
import 'camera.dart';


class ArticleImproverPage extends StatefulWidget{
  const ArticleImproverPage({Key?key}):super(key: key);
  @override
  State<ArticleImproverPage> createState()=> _ArticleImproverPage();
}
class _ArticleImproverPage extends State<ArticleImproverPage>{
  final _controller= TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final ocrImageProvider = Provider.of<OCRImageProvider>(context);
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text('Writing Improver',style: Theme.of(context).textTheme.bodyLarge,),
          ),
        ),
        BlocBuilder<ArticleBloc,ArticleState>(
            builder: (context,state){
              if(state.status=="INIT"){
                return Expanded(
                  flex: 8,
                  child:Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                          children:[
                            Container(
                                child: Text('Content',style: Theme.of(context).textTheme.bodyMedium),
                                alignment: Alignment.centerLeft
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.symmetric(vertical: 15),
                              height: 180,
                              decoration: Theme.of(context).brightness == Brightness.dark ? DarkStyle.boxDecoration : LightStyle.boxDecoration,
                              child: SingleChildScrollView(
                                child: ocrImageProvider.isNull()?
                                TextField(
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "可以在這寫下你的作文或使用照片",
                                    border: InputBorder.none,
                                  ),
                                ):
                                Stack(
                                    children: [
                                      Image.memory(ocrImageProvider.image as Uint8List),
                                      IconButton(onPressed: (){ocrImageProvider.clear();}, icon: Icon(Icons.cancel_outlined,size: 30,color: Colors.red,))
                                    ]
                                ),
                              ),
                            ),

                            Container(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed:(){print('HAHA');},
                                      tooltip: 'Choose come photos.',
                                      icon:Icon(Icons.photo),
                                      iconSize: 36.0,
                                    ),
                                    IconButton(
                                      onPressed:(){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => CameraPage()),
                                        );
                                      },
                                      tooltip: 'Take a photo.',
                                      icon:Icon(Icons.camera_alt_outlined),
                                      iconSize: 36.0,
                                    ),
                                  ],
                                )
                            ),
                            Container(
                              child: Text('Prompt',style: Theme.of(context).textTheme.bodyMedium),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.symmetric(vertical: 15),
                              height: 150,
                              decoration: Theme.of(context).brightness == Brightness.dark ? DarkStyle.boxDecoration : LightStyle.boxDecoration,
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: _controller,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "可以寫下作文主題以及你認為需加強部分\n(選填)",
                                    hintMaxLines: 3,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),

                          ]
                      ),
                    ),
                  ),
                );
              }
              else if(state.status=="PENDING"){
                return Expanded(
                    flex:9,
                    child: Loading()
                );
              }
              else if (state.status=='SUCCESS'){
                return Expanded(
                  flex:8,
                  child: Center(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline,size:40),
                          Text("Success to upload")
                        ],
                      )
                  ),
                );
              }
              else{
                return Expanded(
                  flex:8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child:Icon(Icons.warning_rounded,size:40,color: Colors.red,)
                      ),
                      Text("Fail to upload")
                    ],
                  )
                );
              }
        }),
        BlocBuilder<ArticleBloc,ArticleState>(
          builder: (context,state){
            if(state.status=="INIT"){
              return Expanded(
                  flex: 1,
                  child:FractionallySizedBox(
                      widthFactor: 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ArticleBloc>().add(ArticleEventGraph(Article_Image(ocrImageProvider.file,_controller.text)));
                        },
                        child:Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                        style: Theme.of(context).elevatedButtonTheme.style,
                      )
                  )
              );
            }
            else if(state.status=="PENDING"){
              return Container();
            }
            else{
              return Expanded(
                  flex: 1,
                  child:FractionallySizedBox(
                      widthFactor: 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          ocrImageProvider.clear();
                          context.read<ArticleBloc>().add(ArticleEventRefresh());
                        },
                        child:Text('Reset',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                        style: Theme.of(context).elevatedButtonTheme.style,
                      )
                  )
              );
            }
          }
        ),

      ],
    );
  }

}