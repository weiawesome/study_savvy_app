import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../blocs/bloc_access_methds.dart';
import '../widgets/loading.dart';

class ACCESS_TOKENPage extends StatefulWidget{
  const ACCESS_TOKENPage({Key?key}):super(key: key);
  @override
  State<ACCESS_TOKENPage> createState()=> _ACCESS_TOKENPage();
}

class _ACCESS_TOKENPage extends State<ACCESS_TOKENPage> {
  void _launchURL() async {
    const String url = 'https://chat.openai.com/api/auth/session';
    try{
      await launchUrl(Uri.parse(url));
    }
    catch (e){
      throw("Errrot to open accesstoken page "+e.toString());
    }

  }
  final _controller= TextEditingController();
  @override
  void dispose() {
    // 清理控制器资源
    _controller.dispose();
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
                        Expanded(flex:5,child: Text('TOKEN',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                        Expanded(flex:1,child: Container()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child:Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              flex: 20,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text("Have service of chat-gpt by reverse.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("You can give us your ACCESS_TOKEN.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("We won't charge for this service, then you can use the service powered by Open-AI.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("Furthermore, we will use AES, RSA, SSL/TLS algorithm to encrypt your API_KEY.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("Hence, if you want to have the service, gain you ACCESS_TOKEN and give us.",style: Theme.of(context).textTheme.displaySmall,),
                                ],
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Container()
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(10)),
                              child: TextButton(onPressed: (){_launchURL();}, child: Text('Gain your ACCESS_TOKEN',style: Theme.of(context).textTheme.displayMedium,)),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container()
                          ),
                          BlocBuilder<Access_methodBloc,Access_methodState?>(
                            builder: (context,state){
                              if(state==null){
                                return Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex:4,
                                          child: Text('ACCESS\nTOKEN:',style: Theme.of(context).textTheme.displayMedium,)
                                      ),
                                      Expanded(
                                          flex:6,
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: TextField(
                                              controller: _controller,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                hintText: "API_KEY",
                                                hintMaxLines: 1,
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          )
                                      ),

                                    ],
                                  ),
                                );
                              }
                              else if (state.status=="PENDING"){
                                return Loading();
                              }
                              else if (state.status=="SUCCESS"){
                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.check_circle_outline,color: Color.fromRGBO(48,219,91,1),size: 60,),
                                      Text('Success',style: Theme.of(context).textTheme.displayMedium,)
                                    ],
                                  ),
                                );
                              }
                              else{
                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.dangerous_sharp,color: Colors.red,size: 60,),
                                      Text("Failure",style: Theme.of(context).textTheme.displayMedium,)
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<Access_methodBloc,Access_methodState?>(
                    builder: (context,state){
                      if (state==null){
                        return Expanded(
                            flex: 1,
                            child:FractionallySizedBox(
                                widthFactor: 0.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<Access_methodBloc>().add(Access_methodEventApiKey(_controller.text));
                                    Navigator.pop(context);
                                  },
                                  child:Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                                  style: Theme.of(context).elevatedButtonTheme.style,
                                )
                            )
                        );
                      }
                      else{
                        return Container();
                      }
                    },
                  ),

                ],
              )
          )
      ),
    );
  }
}