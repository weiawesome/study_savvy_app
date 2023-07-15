import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/models/profile/model_profile.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/blocs/profile/bloc_profile.dart';
import 'package:study_savvy_app/widgets/success.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({Key?key}):super(key: key);
  @override
  State<InformationPage> createState()=> _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  void _showAlertDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Warn',style: Theme.of(context).textTheme.displayMedium),
          content: _controller.text.isEmpty?Text("Name 部分不得為空",style: Theme.of(context).textTheme.displaySmall):Text("與原資料相符 未做更動",style: Theme.of(context).textTheme.displaySmall),
          actions: <Widget>[
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('confirm',style: Theme.of(context).textTheme.displaySmall),
            ),
          ],
        );
      },
    );
  }
  int groupValue=0;
  late TextEditingController _controller;
  late ProfileBloc bloc;

  late final String originalName;
  late final String originalGender;

  Map<int,String> genderIndex={
    0:"male",1:"female",2:"other"
  };
  Widget formatGenderUI(int index){
    final String gender=genderIndex[index]!;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text(gender,style: Theme.of(context).textTheme.displaySmall));
  }
  @override
  void initState() {
    super.initState();
    _controller= TextEditingController();
    bloc=BlocProvider.of<ProfileBloc>(context);
    context.read<ProfileBloc>().stream.listen((ProfileState state) {
      if(state.status=="SUCCESS"){
        if(mounted){
          _controller.text=state.profile.name;

          originalName=state.profile.name;
          originalGender=state.profile.gender;

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
    bloc.add(ProfileEventReset());
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
                        if (state.status=="INIT" || state.status=="PENDING") {
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
                                            physics: const NeverScrollableScrollPhysics(),
                                            children: [
                                              CupertinoSlidingSegmentedControl(
                                                  groupValue: groupValue,
                                                  children:{
                                                    0: formatGenderUI(0),
                                                    1: formatGenderUI(1),
                                                    2: formatGenderUI(2)
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
                        else if(state.status=="FAILURE"){
                          return Failure(error: state.message!,);
                        }
                        else if(state.status=="SUCCESS_OTHER"){
                          return Success(message: state.message!);
                        }
                        else{
                          return const Failure(error: "UNKNOWN STATUS");
                        }
                      }
                    )
                  ),

                  Expanded(
                      flex: 1,
                      child: BlocBuilder<ProfileBloc,ProfileState>(
                          builder: (context,state){
                            if(state.status=="SUCCESS"){
                              return FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(_controller.text.isEmpty){
                                        _showAlertDialog(context);
                                      }
                                      else if(_controller.text.toString()==originalName && genderIndex[groupValue]==originalGender){
                                        _showAlertDialog(context);
                                      }
                                      else{
                                        context.read<ProfileBloc>().add(ProfileEventUpdate(UpdateProfile(_controller.text.toString(),genderIndex[groupValue]!)));
                                      }
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
                              );
                            }
                            else{
                              return Container();
                            }
                          }
                      ),
                  ),
                ],
              )
          )
      ),
    );
  }
}