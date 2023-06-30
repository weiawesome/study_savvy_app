import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/provider/theme_provider.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({Key?key}):super(key: key);
  @override
  State<InformationPage> createState()=> _InformationPage();
}

class _InformationPage extends State<InformationPage> {
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
                        Expanded(flex:5,child: Text('Information',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                        Expanded(flex:1,child: Container()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child:Container(),
                  ),
                  Expanded(
                      flex: 1,
                      child:FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ElevatedButton(
                            onPressed: () {  },
                            child:Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:25,fontFamily: 'Play',fontWeight: FontWeight.bold),),
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