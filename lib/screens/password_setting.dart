import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_password.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/widgets/success.dart';

import '../models/model_profile.dart';
import '../widgets/failure.dart';
class PasswordPage extends StatefulWidget{
  const PasswordPage({Key?key}):super(key: key);
  @override
  State<PasswordPage> createState()=> _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKey.currentState!.validate()) {
        context.read<PasswordBloc>().add(PasswordEventUpdate(UpdatePwd(oldPasswordController.text.toString(),newPasswordController.text.toString())));
      }
    }
    return Scaffold(
      body:SafeArea(
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
                        Expanded(flex:5,child: Text('Password',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                        Expanded(flex:1,child: Container()),
                      ],
                    ),
                  ),
                  BlocBuilder<PasswordBloc,PasswordState>(
                      builder: (context,state){
                        if(state.status=="INIT"){
                          return Expanded(
                            flex: 8,
                            child:Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          flex:4,
                                          child: Text('Password:',style: Theme.of(context).textTheme.displayMedium,)
                                      ),
                                      Expanded(
                                          flex:6,
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: TextFormField(
                                              controller: oldPasswordController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Enter the Password",
                                                hintMaxLines: 3,
                                                border: InputBorder.none,
                                              ),
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Empty error';
                                                }
                                                return null;
                                              },
                                            ),
                                          )
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex:4,
                                          child: Text('New\nPassword:',style: Theme.of(context).textTheme.displayMedium,)
                                      ),
                                      Expanded(
                                          flex:6,
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: TextFormField(
                                              controller: newPasswordController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Enter new Password",
                                                hintMaxLines: 1,
                                                border: InputBorder.none,
                                              ),
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Empty Error';
                                                }
                                                else if(value==oldPasswordController.text){
                                                  return 'Same with old Error';
                                                }
                                                return null;
                                              },
                                            ),
                                          )
                                      ),

                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          flex:4,
                                          child: Text('Confirm\nNew\nPassword:',style: Theme.of(context).textTheme.displayMedium,)
                                      ),
                                      Expanded(
                                          flex:6,
                                          child: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 1)),
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: TextFormField(
                                              controller: confirmPasswordController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Confirm new Password",
                                                hintMaxLines: 3,
                                                border: InputBorder.none,
                                              ),
                                              obscureText: true,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Empty Error';
                                                }
                                                else if (value != newPasswordController.text) {
                                                  return 'Match Error';
                                                }
                                                return null;
                                              },
                                              onChanged: (value) {
                                                _formKey.currentState!.validate();  // Re-validate the form when the new password changes
                                              },
                                            ),
                                          )
                                      ),

                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        else if(state.status=="PENDING"){
                          return const Expanded(
                            flex:9,
                            child: Loading(),
                          );
                        }
                        else if(state.status=="SUCCESS"){
                          return const Expanded(
                            flex:8,
                            child: Success(message: "Success to update Password",),
                          );
                        }
                        else if(state.status=="FAILURE"){
                          return Expanded(
                            flex:8,
                            child: Failure(error: state.error!,),
                          );
                        }
                        else{
                          return Container();
                        }
                      }
                  ),
                  BlocBuilder<PasswordBloc,PasswordState>(
                    builder: (context,state){
                      if(state.status=="INIT"){
                        return Expanded(
                            flex: 1,
                            child:FractionallySizedBox(
                                widthFactor: 0.5,
                                child: ElevatedButton(
                                  onPressed: () { submitForm(); },
                                  style: Theme.of(context).elevatedButtonTheme.style,
                                  child:const Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                                )
                            )
                        );
                      }
                      else if(state.status=="PENDING"){
                        return Container();
                      }
                      else if(state.status=="FAILURE" || state.status=="FAILURE"){
                        return Expanded(
                            flex: 1,
                            child:FractionallySizedBox(
                                widthFactor: 0.5,
                                child: ElevatedButton(
                                  onPressed: () { submitForm(); },
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
                  ),
                ],
              )
          )
      ),
    );
  }
}