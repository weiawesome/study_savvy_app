import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:study_savvy_app/models/model_files.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
class SpecificFilePage extends StatefulWidget{
  final File_Info fileInfo;
  const SpecificFilePage({Key?key,required this.fileInfo}):super(key: key);
  @override
  State<SpecificFilePage> createState()=> _SpecificFilePage();
}

class _SpecificFilePage extends State<SpecificFilePage> {
  final Specific_File specificFile=Specific_File("Content","prompt","Summarize-----\n\n\nbflajkbedlj\n-",["details","details"]);

  Future<Uint8List> _downloadImage(String url, String jwtToken) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $jwtToken'},
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
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
                              this.widget.fileInfo.type=='ASR'?
                              Container(
                                color: Colors.black,
                                height: 200,
                                child: FutureBuilder<Uint8List>(
                                  future: _downloadImage('https://study-savvy.com/api/files/resources/graph/2e540dc9-3b25-4f51-b5b2-3583fabc2e53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4ODE4MTk1NywianRpIjoiNDdlMDA1OWMtNDFjOS00YjdjLTk3MWUtMTJiZmU2NDJiYTg5IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2ODgxODE5NTcsImNzcmYiOiI4N2I1Y2Q2OS0xOWQ3LTQ2MjMtOGNmMi1jYjdmZmZjYmI1MWIiLCJleHAiOjE2ODkzOTE1NTd9.jNmZ69n9F_N0mvTl8_DSHoymZMka33goA7D1RBHq2Hw'),
                                  builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      return Image.memory(snapshot.data!);
                                    }
                                  },
                                ),
                              ):
                              Container(color:Colors.green,height: 10,)
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
                            onPressed: () async { await DefaultCacheManager().emptyCache(); },
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