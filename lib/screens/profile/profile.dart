import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/profile/bloc_access_methods.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/blocs/profile/bloc_password.dart';
import 'package:study_savvy_app/blocs/profile/bloc_profile.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/routes.dart';
import 'package:study_savvy_app/widgets/failure.dart';
import 'package:study_savvy_app/widgets/loading.dart';
import 'package:study_savvy_app/widgets/success.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key?key}):super(key: key);
  @override
  State<ProfilePage> createState()=> _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  Map<int,ThemeMode> themeModeIndex={
    0:ThemeMode.system,1:ThemeMode.light,2:ThemeMode.dark
  };
  Map<ThemeMode,int> indexThemeMode={
    ThemeMode.system:0,ThemeMode.light:1,ThemeMode.dark:2
  };
  Map<int,String> themeIndex={
    0:"system",1:"light",2:"dark"
  };
  Widget formatThemeUI(int index){
    final String gender=themeIndex[index]!;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),child: Text(gender,style: Theme.of(context).textTheme.displaySmall));
  }
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);
    int groupValue=indexThemeMode[themeProvider.themeMode]??0;
    void showLogoutDialog(BuildContext context) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return BlocBuilder<OnlineBloc,OnlineState>(
              builder: (context,state){
                if(state.status==null){
                  return CupertinoAlertDialog(
                    title: Text('Logout',style: Theme.of(context).textTheme.displayMedium),
                    content: const Loading(),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('close',style: Theme.of(context).textTheme.displaySmall,),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
                else if(state.status==true && state.message==null){
                  return CupertinoAlertDialog(
                    title: Text('Logout',style: Theme.of(context).textTheme.displayMedium),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDestructiveAction: false,
                        child: Text('cancel',style: Theme.of(context).textTheme.displaySmall,),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          context.read<OnlineBloc>().add(OnlineEventLogout());
                        },
                        child: Text('confirm',style: Theme.of(context).textTheme.displaySmall,),
                      ),
                    ],
                  );
                }
                else if(state.status==true){
                  return CupertinoAlertDialog(
                    title: Text('Logout',style: Theme.of(context).textTheme.displayMedium),
                    content: Failure(error: state.message!,),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('confirm',style: Theme.of(context).textTheme.displaySmall,),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
                else{
                  return CupertinoAlertDialog(
                    title: Text('Logout',style: Theme.of(context).textTheme.displayMedium),
                    content: const Success(message: "Success to logout",),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('confirm',style: Theme.of(context).textTheme.displaySmall,),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              }
          );
        },
      ).then((value){
        bool? status=context.read<OnlineBloc>().state.status;
        context.read<OnlineBloc>().add(OnlineEventReset(status));
      });
    }
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex:1,child: Container()),
              Expanded(flex:5,child: Text('Profile',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
              Expanded(flex:1,child: IconButton(onPressed: (){
                context.read<OnlineBloc>().add(OnlineEventCheck());
                showLogoutDialog(context);
                }, icon: const Icon(Icons.logout),alignment: Alignment.centerRight,)),
            ],
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Icon(Icons.face_unlock_rounded,size: 130,),
            )
        ),
        Expanded(
          flex: 7,
          child:Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Text('Information Setting',style: Theme.of(context).textTheme.displayMedium)
                          ),
                          TextButton(
                              onPressed: (){Navigator.pushNamed(context, Routes.information,);context.read<ProfileBloc>().add(ProfileEventGet());},
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).hintColor;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Information",style: Theme.of(context).textTheme.displaySmall),
                                  Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                                ],
                              )
                          ),
                          TextButton(
                              onPressed: (){
                                context.read<PasswordBloc>().add(PasswordEventReset());
                                Navigator.pushNamed(context, Routes.password);
                                },
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).hintColor;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Change Password",style: Theme.of(context).textTheme.displaySmall),
                                  Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text('CHAT-GPT method',style: Theme.of(context).textTheme.displayMedium)
                          ),
                          TextButton(
                              onPressed: (){context.read<AccessMethodBloc>().add(AccessMethodEventReset());Navigator.pushNamed(context, Routes.apikey);},
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).hintColor;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Api_Key",style: Theme.of(context).textTheme.displaySmall),
                                  Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                                ],
                              )
                          ),
                          TextButton(
                              onPressed: (){context.read<AccessMethodBloc>().add(AccessMethodEventReset());Navigator.pushNamed(context, Routes.accessToken);},
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).hintColor;
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Access_Token",style: Theme.of(context).textTheme.displaySmall),
                                  Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Text('Preference Setting',style: Theme.of(context).textTheme.displayMedium)
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Theme Setting",style: Theme.of(context).textTheme.displaySmall),
                              Theme.of(context).brightness==Brightness.light?
                              Icon(Icons.light_mode,size: 25,color: Theme.of(context).hintColor):
                              Icon(Icons.dark_mode,size: 25,color: Theme.of(context).hintColor)
                            ],
                          ),
                          const Divider(),
                          SizedBox(
                            height: 40,
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                CupertinoSlidingSegmentedControl(
                                    groupValue: groupValue,
                                    children:{
                                      0: formatThemeUI(0),
                                      1: formatThemeUI(1),
                                      2: formatThemeUI(2)
                                    },
                                    onValueChanged: (value){
                                      themeProvider.themeMode=themeModeIndex[value]!;
                                      setState(() {
                                        groupValue=value!;
                                      });
                                    }
                                )
                              ],
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context).hintColor;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Empty Cache",style: Theme.of(context).textTheme.displaySmall),
                                Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                              ],
                            ),
                            onPressed: () async {
                              await DefaultCacheManager().emptyCache();
                            },
                          ),
                          TextButton(
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context).hintColor;
                                  }
                                  return Colors.transparent;
                                },
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("一鍵登入(未來會刪除)",style: Theme.of(context).textTheme.displaySmall),
                                Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
                              ],
                            ),
                            onPressed: () async {
                              JwtService jwtService=JwtService();
                              await jwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4OTM1MzIwNCwianRpIjoiY2IyZDQyYzAtNDA5ZC00ZjIwLWE5OWMtMjM4Y2M0NWJiNzVhIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2ODkzNTMyMDQsImNzcmYiOiI2MmJiMTgxMS1lYjZhLTRkZWYtOTQ2Mi1kZDE3YTVmOTRmMTciLCJleHAiOjE2OTA1NjI4MDR9.VR2yL1m9DMak5_9NczOAo4QJvl7ouZ_SuCCTRFlxBOI");
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              )
          ),
        ),
      ],
    );
  }
}