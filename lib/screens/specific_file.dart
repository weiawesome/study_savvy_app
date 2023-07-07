import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_specific_file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:study_savvy_app/services/api_files.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
import 'package:study_savvy_app/widgets/loading.dart';
class SpecificFilePage extends StatefulWidget{
  const SpecificFilePage({Key?key}):super(key: key);
  @override
  State<SpecificFilePage> createState()=> _SpecificFilePage();
}

class _SpecificFilePage extends State<SpecificFilePage> {
  late FileBloc bloc;
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    super.initState();
    bloc=BlocProvider.of<FileBloc>(context);
  }
  @override
  void dispose() {
    bloc.add(FileEventClear());
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
          child:Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex:1,child: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new),alignment: Alignment.bottomLeft,)),
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
                              if(state.status=="INIT"){
                                return Loading();
                              }
                              else if(state.status=="SUCCESS"){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).hintColor),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: Text("Introduce"),
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
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Text('Summarize',style: Theme.of(context).textTheme.labelMedium,),
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 15),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                alignment: Alignment.topLeft,
                                                child: Text(state.file!.summarize,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                              )
                                            ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children:[
                                          ExpansionTile(
                                            title: Text('Details',style: Theme.of(context).textTheme.labelMedium,),
                                            children: [
                                              Column(
                                                children: state.file!.details.map((item){
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(vertical: 15),
                                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                                    padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                    alignment: Alignment.topLeft,
                                                    child: Text(item,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                                  );
                                                }).toList(),
                                              )
                                            ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),


                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                              title: Text('Prompt',style: Theme.of(context).textTheme.labelMedium,),
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(vertical: 15),
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                  alignment: Alignment.topLeft,
                                                  child: Text(state.file!.prompt,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                                )
                                              ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Text('Content',style: Theme.of(context).textTheme.labelMedium,),
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(vertical: 15),
                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                                alignment: Alignment.topLeft,
                                                child: Text(state.file!.content,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                              )
                                            ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    state.type=="OCR"?
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Text('Original Photo',style: Theme.of(context).textTheme.labelMedium,),
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(vertical: 15),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: Image.memory(state.media as Uint8List)
                                              )
                                            ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),
                                        ],
                                      ),
                                    ):
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            title: Text('Original Audio',style: Theme.of(context).textTheme.labelMedium,),
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.symmetric(vertical: 15),
                                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                                  child: TextButton(
                                                    onPressed: () { print("HAHA");},
                                                    child: Icon(Icons.play_circle_fill_rounded,color: Theme.of(context).hintColor,size: 50,),
                                                  )
                                              )
                                            ],
                                            iconColor: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }
                              else{
                                return Container();
                              }
                            },
                          )
                      ),
                    )
                  ),
                  Expanded(
                      flex: 1,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () { Navigator.pop(context); },
                            child:Text("ReGenerate",textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                            style: Theme.of(context).elevatedButtonTheme.style,
                          ),
                          ElevatedButton(
                            onPressed: () async { await DefaultCacheManager().emptyCache(); await JwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4ODE5NjYyMywianRpIjoiYmU4ZGQ2YzctMWRmNC00Nzg0LTgzOTgtZWQ5ODZhNGM5ZGM1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2ODgxOTY2MjMsImNzcmYiOiJhNjYzNzFiNS01NWUwLTRjMzAtOGRkNS0zM2E4M2FjZGI2MDkiLCJleHAiOjE2ODk0MDYyMjN9.sXF-_dRljEvsUzH7NdnKSTbQX36NTD_iOncnrcVocYY");getSpecificFile("2e540dc9-3b25-4f51-b5b2-3583fabc2e53");},
                            child:Text("Delete",textAlign: TextAlign.center,style: TextStyle(color: Colors.redAccent, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                            style: Theme.of(context).elevatedButtonTheme.style,
                          )
                        ],
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}