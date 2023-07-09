import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/bloc_access_methods.dart';
import '../blocs/bloc_profile.dart';
import '../blocs/provider/theme_provider.dart';
import '../services/jwt_storage.dart';
import '../utils/routes.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key?key}):super(key: key);
  @override
  State<ProfilePage> createState()=> _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout',style: Theme.of(context).textTheme.displayMedium),
          actions: <Widget>[
            TextButton(
              child: Text('cancel',style: Theme.of(context).textTheme.displaySmall,),
              onPressed: () {
                Navigator.of(context).pop();  
              },
            ),
            TextButton(
              child: Text('confirm',style: Theme.of(context).textTheme.displaySmall),
              onPressed: () async {
                await JwtService.deleteJwt().then((value) => {
                  Navigator.of(context).pop()
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                _showLogoutDialog(context);
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
                          Text('Information Setting',style: Theme.of(context).textTheme.displayMedium),
                          Container(
                            margin: const EdgeInsets.only(top:20),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
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
                                    Text("Personal Information",style: Theme.of(context).textTheme.displaySmall),
                                    const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                  ],
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top:5),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
                                onPressed: (){Navigator.pushNamed(context, Routes.password);},
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed)) {
                                        return Theme.of(context).hintColor;
                                      }
                                      // 其他状态下的背景色
                                      return Colors.transparent;
                                    },
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Change Password",style: Theme.of(context).textTheme.displaySmall),
                                    const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                  ],
                                )
                            ),
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
                          Text('CHAT-GPT method',style: Theme.of(context).textTheme.displayMedium),
                          Container(
                            margin: const EdgeInsets.only(top:20),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
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
                                    Text("API_KEY",style: Theme.of(context).textTheme.displaySmall),
                                    const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                  ],
                                )
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top:5),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
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
                                    Text("ACCESS_TOKEN",style: Theme.of(context).textTheme.displaySmall),
                                    const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                  ],
                                )
                            ),
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
                          Text('Preference Setting',style: Theme.of(context).textTheme.displayMedium),
                          Container(
                            margin: const EdgeInsets.only(top:20),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
                              style: ButtonStyle(
                                overlayColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.pressed)) {
                                      return Theme.of(context).hintColor;
                                    }
                                    // 其他状态下的背景色
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Theme Setting",style: Theme.of(context).textTheme.displaySmall),
                                  const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                ],
                              ),
                              onPressed: () {
                                showBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                              flex: 3,
                                              child:Center(
                                                child: Text('Mode',style: Theme.of(context).textTheme.bodyLarge,),
                                              )
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              alignment: Alignment.topLeft,
                                              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  TextButton(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('System',style: Theme.of(context).textTheme.displayMedium),
                                                          themeProvider.themeMode==ThemeMode.system? const Icon(Icons.check):Container()
                                                        ]
                                                    ),
                                                    onPressed: () => {
                                                      themeProvider.themeMode=ThemeMode.system,
                                                      Navigator.pop(context),
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Dark',style: Theme.of(context).textTheme.displayMedium),
                                                          themeProvider.themeMode==ThemeMode.dark? const Icon(Icons.check):Container()
                                                        ]
                                                    ),
                                                    onPressed: () => {
                                                      themeProvider.themeMode=ThemeMode.dark,
                                                      Navigator.pop(context)
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text('Light',style: Theme.of(context).textTheme.displayMedium),
                                                          themeProvider.themeMode==ThemeMode.light? const Icon(Icons.check):Container()
                                                        ]
                                                    ),
                                                    onPressed: () => {
                                                      themeProvider.themeMode=ThemeMode.light,
                                                      Navigator.pop(context)
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top:5),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
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
                                  const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                ],
                              ),
                              onPressed: () async {
                                await DefaultCacheManager().emptyCache();
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top:5),
                            color: const Color.fromRGBO(118, 118, 128, 0.24),
                            child: TextButton(
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
                                  const Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                ],
                              ),
                              onPressed: () async {
                                await JwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY4ODE5NjYyMywianRpIjoiYmU4ZGQ2YzctMWRmNC00Nzg0LTgzOTgtZWQ5ODZhNGM5ZGM1IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2ODgxOTY2MjMsImNzcmYiOiJhNjYzNzFiNS01NWUwLTRjMzAtOGRkNS0zM2E4M2FjZGI2MDkiLCJleHAiOjE2ODk0MDYyMjN9.sXF-_dRljEvsUzH7NdnKSTbQX36NTD_iOncnrcVocYY");
                              },
                            ),
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