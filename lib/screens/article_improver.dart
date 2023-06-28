import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import '../blocs/provider/theme_provider.dart';

class ArticleImproverPage extends StatefulWidget{
  const ArticleImproverPage({Key?key}):super(key: key);
  @override
  State<ArticleImproverPage> createState()=> _ArticleImproverPage();
}
class _ArticleImproverPage extends State<ArticleImproverPage>{
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body:Padding(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Text('Writing Improver',style: Theme.of(context).textTheme.bodyLarge,),
                ),
              ),
              Expanded(
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
                              child: TextField(
                                maxLines: null,  // 允许TextField无限扩展
                                keyboardType: TextInputType.multiline,  // 支持多行文本
                                decoration: InputDecoration(
                                  hintText: (themeProvider.themeMode==ThemeMode.light).toString(),
                                  border: InputBorder.none,  // 这里将 border 设置为 none
                                ),
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
                                    onPressed:(){print('HAHA');},
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
                                maxLines: null,  // 允许TextField无限扩展
                                keyboardType: TextInputType.multiline,  // 支持多行文本
                                decoration: InputDecoration(
                                  hintText: (themeProvider.themeMode==ThemeMode.light).toString(),
                                  border: InputBorder.none,  // 这里将 border 设置为 none
                                ),
                              ),
                            ),
                          ),

                        ]
                    ),
                  ),
                ),
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
          ) ,

        )
    );
  }

}