import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_jwt.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:study_savvy_app/services/jwt_storage.dart';
class SpecificFilePage extends StatefulWidget{
  final File_Info fileInfo;
  const SpecificFilePage({Key?key,required this.fileInfo}):super(key: key);
  @override
  State<SpecificFilePage> createState()=> _SpecificFilePage();
}

class _SpecificFilePage extends State<SpecificFilePage> {
  final Specific_File specificFile=Specific_File("Content","prompt","Summarize-----\n\n\nbflajkbedlj\n-",["details","details"]);
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                child: Column(
                                  children: [
                                    Text('Summarize',style: Theme.of(context).textTheme.labelMedium,),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(specificFile.summarize,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                child: Column(
                                  children:[
                                    Text('Details',style: Theme.of(context).textTheme.labelMedium,),
                                    Column(
                                      children: specificFile.details.map((item){
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
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                child: Column(
                                  children: [
                                    Text('Prompt',style: Theme.of(context).textTheme.labelMedium,),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(specificFile.summarize,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.grey[300]:Colors.black),
                                child: Column(
                                  children: [
                                    Text('Content',style: Theme.of(context).textTheme.labelMedium,),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.grey[300]),
                                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                                      alignment: Alignment.topLeft,
                                      child: Text(specificFile.summarize,style: Theme.of(context).textTheme.labelSmall,maxLines: null,),
                                    )
                                  ],
                                ),
                              ),
                              this.widget.fileInfo.type=='ASR'?Container(color: Colors.red,height: 10,):Container(color:Colors.green,height: 10,)
                            ],
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
                            onPressed: () { Navigator.pop(context); },
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