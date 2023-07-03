import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_access_methds.dart';
import 'package:study_savvy_app/widgets/loading.dart';
class API_KEYPage extends StatefulWidget{
  const API_KEYPage({Key?key}):super(key: key);
  @override
  State<API_KEYPage> createState()=> _API_KEYPage();
}

class _API_KEYPage extends State<API_KEYPage> {
  final _controller= TextEditingController();
  @override
  void dispose() {
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
                        Expanded(flex:5,child: Text('API_KEY',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
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
                                  Text("To have the service of chat-gpt.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("You can give us your API_KEY in Open-AI.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("We won't charge for this service, then you can use the service powered by Open-AI.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("Furthermore, we will use AES, RSA, SSL/TLS algorithm to encrypt your API_KEY.",style: Theme.of(context).textTheme.displaySmall,),
                                  Text("Hence, if you want to have the service, gain you API_KEY and give us.",style: Theme.of(context).textTheme.displaySmall,),
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

                              child: TextButton(onPressed: (){}, child: Text('Gain your API_KEY',style: Theme.of(context).textTheme.displayMedium,)),
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
                                          child: Text('API_KEY:',style: Theme.of(context).textTheme.displayMedium,)
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
                      if(state==null){
                        return Expanded(
                            flex: 1,
                            child:FractionallySizedBox(
                                widthFactor: 0.5,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<Access_methodBloc>().add(Access_methodEventApiKey(_controller.text));
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
                  )
                ],
              )
          )
      ),
    );
  }
}