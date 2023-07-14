import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/files/bloc_specific_file.dart';
import 'package:study_savvy_app/models/files/model_files.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/success.dart';

class SpecificFilePage extends StatefulWidget{
  const SpecificFilePage({Key?key}):super(key: key);
  @override
  State<SpecificFilePage> createState()=> _SpecificFilePage();
}

class _SpecificFilePage extends State<SpecificFilePage> {
  late TextEditingController _promptController;
  late TextEditingController _contentController;
  late FileBloc bloc;
  bool init=true;
  bool? playState=false;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    _contentController= TextEditingController();
    _promptController= TextEditingController();
    bloc=BlocProvider.of<FileBloc>(context);
    context.read<FileBloc>().stream.listen((FileState state) {
      if(state.status=="SUCCESS"){
        if(mounted){
          _promptController.text=state.file!.prompt;
          _contentController.text=state.file!.content;
        }
      }
    });
  }
  @override
  void dispose() {
    audioPlayer.stop();
    audioPlayer.dispose();
    bloc.add(FileEventClear());
    _contentController.dispose();
    _promptController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
            child:Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex:1,child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new),alignment: Alignment.bottomLeft,)),
                          Expanded(flex:5,child: Text('SpecificFile',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                          Expanded(flex:1,child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child:SingleChildScrollView(
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: BlocBuilder<FileBloc,FileState>(
                              builder: (context,state){
                                if(state.status=="INIT" || state.status=="PENDING"){
                                  return const Loading();
                                }
                                else if(state.status=="SUCCESS"){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 10),
                                              child: const Text("Introduce"),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Summarize",style: Theme.of(context).textTheme.headlineMedium,),
                                                Text("代表AI做出的重點或評分",style: Theme.of(context).textTheme.headlineSmall,),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Details",style: Theme.of(context).textTheme.headlineMedium,),
                                                Text("代表AI對於每段細節做的評論",style: Theme.of(context).textTheme.headlineSmall,),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Prompt",style: Theme.of(context).textTheme.headlineMedium,),
                                                Text("代表你個人所下的提示詞(可做更動)",style: Theme.of(context).textTheme.headlineSmall,),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Content",style: Theme.of(context).textTheme.headlineMedium),
                                                Text("代表文章內容或語音內容(可做更動)",style: Theme.of(context).textTheme.headlineSmall),
                                              ],
                                            ),
                                          ],
                                        )
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                              title: Text('Summarize',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                                  padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(state.file!.summarize,style: Theme.of(context).textTheme.headlineSmall,maxLines: null,),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children:[
                                            ExpansionTile(
                                              title: Text('Details',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                              children: [
                                                Column(
                                                  children: state.file!.details.map((item){
                                                    return Container(
                                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                                      decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                                      alignment: Alignment.topLeft,
                                                      child: Text(item,style: Theme.of(context).textTheme.headlineSmall,maxLines: null,),
                                                    );
                                                  }).toList(),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                                title: Text('Prompt',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    alignment: Alignment.topLeft,
                                                    child: TextField(
                                                      controller: _promptController,
                                                      keyboardType: TextInputType.multiline,
                                                      style: Theme.of(context).textTheme.headlineSmall,
                                                      decoration: const InputDecoration(
                                                        border: InputBorder.none,
                                                      ),
                                                      maxLines: null,
                                                    ),
                                                  )
                                                ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                              title: Text('Content',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 15),
                                                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: TextField(
                                                    controller: _contentController,
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    style: Theme.of(context).textTheme.headlineSmall,
                                                    maxLines: null,),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (state.type=="OCR") Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                              title: Text('Original Photo',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                              children: [
                                                Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: state.media==null?const Failure(error: "No Image Source"):Image.memory(state.media as Uint8List)
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ) else Container(
                                        margin: const EdgeInsets.symmetric(vertical: 10),
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                        child: Column(
                                          children: [
                                            ExpansionTile(
                                              title: Text('Original Audio',style: Theme.of(context).textTheme.labelMedium,),
                                              iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                              children: [
                                                Container(
                                                    margin: const EdgeInsets.symmetric(vertical: 15),
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        if(init){
                                                          try{
                                                            audioPlayer.setSourceBytes(state.media!);
                                                            audioPlayer.play(audioPlayer.source!);
                                                            setState(() {
                                                              init=false;
                                                              playState=true;
                                                            });
                                                          }
                                                          catch (e){
                                                            setState(() {
                                                              playState=null;
                                                            });
                                                          }
                                                        }
                                                        else{
                                                          if(playState==true){
                                                            audioPlayer.pause();
                                                            setState(() {
                                                              playState=false;
                                                            });
                                                          }
                                                          else if(playState==false){
                                                            audioPlayer.resume();
                                                            setState(() {
                                                              playState=true;
                                                            });
                                                          }
                                                        }

                                                        },
                                                      child: playState==null?const Failure(error: "Error to play"):playState==true?Icon(Icons.pause_circle_filled_outlined,color: Theme.of(context).hintColor,size: 50,):Icon(Icons.play_circle_fill_rounded,color: Theme.of(context).hintColor,size: 50,),

                                                    )
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                }
                                else if(state.status=="FAILURE"){
                                  return Failure(error: state.message!,);
                                }
                                else if(state.status=="SUCCESS_OTHER"){
                                  return Success(message: state.message!,);
                                }
                                else{
                                  return Container();
                                }
                              },
                            )
                        ),
                      )
                    ),
                    BlocBuilder<FileBloc,FileState>(
                      builder: (context,state){
                        if(state.status=="SUCCESS"){
                          return Expanded(
                              flex: 1,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () async {
                                      EditFile file=EditFile(state.id!,_promptController.text.toString(),_contentController.text.toString());
                                      if(state.type=="OCR"){
                                        context.read<FileBloc>().add(FileEventEditOCR(file));
                                      }
                                      else{
                                        context.read<FileBloc>().add(FileEventEditASR(file));
                                      }
                                    },
                                    style: Theme.of(context).elevatedButtonTheme.style,
                                    child:const Text("ReGenerate",textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      context.read<FileBloc>().add(FileEventDelete(state.id!));
                                    },
                                    style: Theme.of(context).elevatedButtonTheme.style,
                                    child:const Text("Delete",textAlign: TextAlign.center,style: TextStyle(color: Colors.redAccent, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                                  )
                                ],
                              )
                          );
                        }
                        else{
                          return Expanded(
                              flex:1,
                              child: Container()
                          );
                        }
                      },
                    ),

                  ],
                )
            )
        ),
      ),
    );
  }
}