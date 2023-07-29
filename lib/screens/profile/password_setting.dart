import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/profile/bloc_password.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/widgets/success.dart';
import 'package:study_savvy_app/models/profile/model_profile.dart';
import 'package:study_savvy_app/widgets/failure.dart';

class PasswordPage extends StatefulWidget{
  const PasswordPage({Key?key}):super(key: key);
  @override
  State<PasswordPage> createState()=> _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  final _formKeyOldPassword = GlobalKey<FormState>();
  final _formKeyNewPassword = GlobalKey<FormState>();
  final _formKeyConfirmPassword = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FocusNode oldPasswordNode=FocusNode();
  final FocusNode newPasswordNode=FocusNode();
  final FocusNode confirmPasswordNode=FocusNode();

  @override
  void dispose() {
    oldPasswordNode.dispose();
    oldPasswordController.dispose();
    newPasswordNode.dispose();
    newPasswordController.dispose();
    confirmPasswordNode.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submitForm() {
      if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate() && _formKeyConfirmPassword.currentState!.validate()) {
        context.read<PasswordBloc>().add(PasswordEventUpdate(UpdatePwd(oldPasswordController.text.toString(),newPasswordController.text.toString())));
      }
    }
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
                          Expanded(flex:5,child: Text('Password',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                          Expanded(flex:1,child: Container()),
                        ],
                      ),
                    ),
                    BlocBuilder<PasswordBloc,PasswordState>(
                        builder: (context,state){
                          if(state.status=="INIT"){
                            return Expanded(
                              flex: 9,
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Password Edit :',style: Theme.of(context).textTheme.displayMedium,),
                                        const Divider(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                          child: Form(
                                            key: _formKeyOldPassword,
                                            child: TextFormField(
                                              controller: oldPasswordController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Enter the Password",
                                                hintMaxLines: 1,
                                                border: InputBorder.none,
                                              ),
                                              obscureText: true,
                                              focusNode: oldPasswordNode,
                                              onFieldSubmitted: (value){
                                                if (_formKeyOldPassword.currentState!.validate()){
                                                  FocusScope.of(context).requestFocus(newPasswordNode);
                                                }
                                                else{
                                                  FocusScope.of(context).requestFocus(oldPasswordNode);
                                                }
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Empty Error';
                                                }
                                                else if(value.contains(' ')){
                                                  return 'Space Error';
                                                }
                                                else if(value.length<8){
                                                  return 'At least 8 chars Error';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                          child: Form(
                                            key: _formKeyNewPassword,
                                            child: TextFormField(
                                              controller: newPasswordController,
                                              maxLines: 1,
                                              focusNode: newPasswordNode,
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
                                                else if(value==oldPasswordController.text.toString()){
                                                  return 'Same with current Error';
                                                }
                                                else if(value.contains(' ')){
                                                  return 'Have space Error';
                                                }
                                                else if(value.length<8){
                                                  return 'At least 8 chars Error';
                                                }
                                                return null;
                                              },
                                              onFieldSubmitted: (value){
                                                if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate()){
                                                  FocusScope.of(context).requestFocus(confirmPasswordNode);
                                                }
                                                else{
                                                  FocusScope.of(context).requestFocus(newPasswordNode);
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 15),
                                          decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(10)),border: Border.all(color: Theme.of(context).brightness==Brightness.light?LightStyle.borderColor:DarkStyle.borderColor,)),
                                          child: Form(
                                            key: _formKeyConfirmPassword,
                                            child: TextFormField(
                                              controller: confirmPasswordController,
                                              maxLines: 1,
                                              decoration: const InputDecoration(
                                                hintText: "Confirm new Password",
                                                hintMaxLines: 1,
                                                border: InputBorder.none,
                                              ),
                                              obscureText: true,
                                              focusNode: confirmPasswordNode,
                                              onFieldSubmitted: (value){
                                                if (_formKeyOldPassword.currentState!.validate() && _formKeyNewPassword.currentState!.validate() && _formKeyConfirmPassword.currentState!.validate()){
                                                  submitForm();
                                                }
                                                else{
                                                  FocusScope.of(context).requestFocus(confirmPasswordNode);
                                                }
                                              },
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Empty Error';
                                                }
                                                else if (value != newPasswordController.text.toString()) {
                                                  return 'Match Error';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Center(
                                    child: FractionallySizedBox(
                                        widthFactor: 0.5,
                                        child: ElevatedButton(
                                          onPressed: () { submitForm(); },
                                          style: Theme.of(context).elevatedButtonTheme.style,
                                          child:const Text('Done',textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize:23,fontFamily: 'Play',fontWeight: FontWeight.bold),),
                                        )
                                    ),
                                  )
                                ],
                              )
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
                  ],
                )
            )
        ),
      ),
    );
  }
}