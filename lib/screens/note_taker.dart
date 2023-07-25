import 'package:flutter/material.dart';
import 'package:study_savvy_app/styles/custom_style.dart';

class NoteTakerPage extends StatefulWidget {
  const NoteTakerPage({Key?key}):super(key: key);

  @override
  State<NoteTakerPage> createState() => _NoteTakerPageState();
}

class _NoteTakerPageState extends State<NoteTakerPage> {
  @override
  Widget build(BuildContext context) {
    return 
    //Scaffold(
      //appBar: AppBar(
      //  title: Text('Note taker',style: Theme.of(context).textTheme.bodyLarge,),
      //),
      //body: 
      Column(
        children: [
          Expanded(
            flex:1,
            child: Text('Note taker',style: Theme.of(context).textTheme.bodyLarge,),),
          Expanded(
            flex:6,
            child: Container(
                    width: 205,
                    height: 230,
                    decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xA7A7A7),
                              width: 2,
                            ),
                          ),
                    child: IconButton(
                            icon: Image.asset(
                              'assets/images/recording.png',
                              width: 203, 
                              height: 228,),
                            //iconSize: 100,
                            //padding: const EdgeInsets.all(10),
                            onPressed: () {},
                          )
                  )
          ),
          //Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200], 
              value: 0.5,
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  children:[
                      Container(
                        child: Text('Prompt',style: Theme.of(context).textTheme.bodyMedium),
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 121,
                        decoration: Theme.of(context).brightness == Brightness.dark ? DarkStyle.boxDecoration : LightStyle.boxDecoration,
                        child: const SingleChildScrollView(
                          child: TextField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "(今日課堂主題)",
                              hintMaxLines: 3,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                  ]
                ),
            )
          ),
          Expanded(
              flex: 1,
              child:FractionallySizedBox(
                  widthFactor: 0.5,
                  child: ElevatedButton(
                    onPressed: () {  },
                    child:Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                    style: Theme.of(context).elevatedButtonTheme.style,
                  )
              )
          ),
        ]
      );
    //);  
  }
}