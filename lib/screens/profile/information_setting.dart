import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/blocs/profile/bloc_profile.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({Key?key}):super(key: key);
  @override
  State<InformationPage> createState()=> _InformationPage();
}

class _InformationPage extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      children: [
                                        Text('Email:', style: Theme.of(context).textTheme.displayMedium,),
                                        Text(state.profile.mail, style: Theme.of(context).textTheme.displaySmall),
                                        Text('Name:', style: Theme.of(context).textTheme.displayMedium,),
                                        Text(state.profile.name, style: Theme.of(context).textTheme.displaySmall),
                                        Text('Gender:', style: Theme.of(context).textTheme.displayMedium,),
                                        Text(state.profile.gender, style: Theme.of(context).textTheme.displaySmall),
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
                                      'Done', textAlign: TextAlign.center,
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