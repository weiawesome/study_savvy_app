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
                    child:Container(
                      child: Column(
                        children: [
                          Text(context.watch<JWTBloc>().state.toString()),
                          TextButton(onPressed: () async {await JwtService.saveJwt("Wei");context.read<JWTBloc>().add(JWTEventGet());}, child: Text("AA"))
                        ],
                      )
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ElevatedButton(
                            onPressed: () { Navigator.pop(context); },
                            child:Text("ReGenerate",textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                            style: Theme.of(context).elevatedButtonTheme.style,
                          )
                      )
                  ),
                ],
              )
          )
      ),
    );
  }
}