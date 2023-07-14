import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/blocs/profile/bloc_profile.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({Key?key}):super(key: key);
  @override
  State<InformationPage> createState()=> _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  int groupValue=0;
  late TextEditingController _controller;
  late ProfileBloc bloc;
  @override
  void initState() {
    super.initState();
    _controller= TextEditingController();
    bloc=BlocProvider.of<ProfileBloc>(context);
    context.read<ProfileBloc>().stream.listen((ProfileState state) {
      if(state.status=="SUCCESS"){
        if(mounted){
          _controller.text=state.profile.name;
          setState(() {
            if(state.profile.gender=="male"){
              groupValue=0;
            } else if(state.profile.gender=="female"){
              groupValue=1;
            }else{
              groupValue=2;
            }
          });

        }
      }
    });
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1,
                            child: IconButton(onPressed: () {
                              Navigator.pop(context);
                            },
                              icon: const Icon(Icons.arrow_back_ios_new),
                              alignment: Alignment.bottomLeft,)),
                        Expanded(flex: 5,
                          child: Text('Information', style: Theme
                              .of(context)
                              .textTheme
                              .bodyLarge,
                            textAlign: TextAlign.center,),),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: BlocBuilder<ProfileBloc,ProfileState>(
                      builder: (context,state) {
                        if (state.status=="INIT") {
                          return const Loading();
                        }
                        else if(state.status=="SUCCESS"){
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(flex: 1,child: Container(),),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Text('Name:', style: Theme.of(context).textTheme.displayMedium,)
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor)),
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: TextField(
                                              controller: _controller,
                                              // textAlign: TextAlign.center,
                                              textAlignVertical: TextAlignVertical.center,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                  hintText: "Name",
                                                  hintMaxLines: 1,
                                                  border: InputBorder.none,
                                                  floatingLabelAlignment: FloatingLabelAlignment.center
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1,child: Container(),),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Text('Email:', style: Theme.of(context).textTheme.displayMedium,)
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(state.profile.mail, style: Theme.of(context).textTheme.displaySmall)
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1,child: Container(),),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text('Gender:', style: Theme.of(context).textTheme.displayMedium,)
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: ListView(
                                            children: [
                                              CupertinoSlidingSegmentedControl(
                                                  groupValue: groupValue,
                                                  children:{
                                                    0: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text("Male",style: Theme.of(context).textTheme.displaySmall)),
                                                    1: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text("Female",style: Theme.of(context).textTheme.displaySmall)),
                                                    2: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text("Other",style: Theme.of(context).textTheme.displaySmall))
                                                  },
                                                  onValueChanged: (value){
                                                    setState(() {
                                                      groupValue=value!;
                                                    });
                                                  }
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(flex: 1,child: Container(),),

                              ],
                            ),
                          );
                        }
                        else{
                          return Failure(error: state.error!,);
                        }
                      }
                    )
                  ),
                  Expanded(
                      flex: 1,
                      child: FractionallySizedBox(
                          widthFactor: 0.5,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: Theme
                                .of(context)
                                .elevatedButtonTheme
                                .style,
                            child: const Text(
                              'Save', textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Play',
                                  fontWeight: FontWeight.bold),),
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