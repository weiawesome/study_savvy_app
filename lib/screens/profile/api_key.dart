import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiKeyPage extends StatefulWidget{
  const ApiKeyPage({Key?key}):super(key: key);
  @override
  State<ApiKeyPage> createState()=> _ApiKeyPage();
}

class _ApiKeyPage extends State<ApiKeyPage> {
  void _launchURL() async {
    const String url = 'https://platform.openai.com/account/api-keys';
    try{
      await launchUrl(Uri.parse(url));
    }
    catch (e){
      throw("Error to open apikey page $e");
    }
  }
  final _controller= TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                          Expanded(flex:5,child: Text('Api_Key',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                          Expanded(flex:1,child: Container()),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child:Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                            BlocBuilder<AccessMethodBloc,AccessMethodState?>(
                              builder: (context,state){
                                if(state==null){
                                  return Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Api_Key:',style: Theme.of(context).textTheme.displayMedium,),
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          margin: const EdgeInsets.only(top: 10),
                                          child: TextField(
                                            controller: _controller,
                                            maxLines: 1,
                                            decoration: const InputDecoration(
                                              hintText: "Api_Key",
                                              hintMaxLines: 1,
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                                else if (state.status=="PENDING"){
                                  return const Loading();
                                }
                                else if (state.status=="SUCCESS"){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.check_circle_outline,color: Color.fromRGBO(48,219,91,1),size: 60,),
                                      Text('Success',style: Theme.of(context).textTheme.displayMedium,)
                                    ],
                                  );
                                }
                                else{
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(Icons.dangerous_sharp,color: Colors.red,size: 60,),
                                      Text("Failure",style: Theme.of(context).textTheme.displayMedium,)
                                    ],
                                  );
                                }

                              },
                            ),
                            Expanded(
                                flex: 15,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("To have the service of chat-gpt.",style: Theme.of(context).textTheme.displaySmall,),
                                    Text("You can give us your Api_Key in Open-AI.",style: Theme.of(context).textTheme.displaySmall,),
                                    Text("We won't charge for this service, then you can use the service powered by Open-AI.",style: Theme.of(context).textTheme.displaySmall,),
                                    Text("Furthermore, we will use AES, RSA, SSL/TLS algorithm to encrypt your Api_Key.",style: Theme.of(context).textTheme.displaySmall,),
                                    Text("Hence, if you want to have the service, gain you Api_Key and give us.",style: Theme.of(context).textTheme.displaySmall,),
                                  ],
                                )
                            ),
                            Expanded(
                              flex: 4,
                              child: TextButton(
                                  onPressed: (){_launchURL();},
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                                      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor),borderRadius: BorderRadius.circular(10)),
                                      child: Text('Gain your Api_Key',style: Theme.of(context).textTheme.displaySmall,)
                                  )
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<AccessMethodBloc,AccessMethodState?>(
                      builder: (context,state){
                        if(state==null){
                          return Expanded(
                              flex: 1,
                              child:FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<AccessMethodBloc>().add(AccessMethodEventApiKey(_controller.text));
                                    },
                                    style: Theme.of(context).elevatedButtonTheme.style,
                                    child:const Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
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
      ),
    );
  }
}