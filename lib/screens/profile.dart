import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../blocs/provider/theme_provider.dart';

class ProfilePage extends StatefulWidget{
  const ProfilePage({Key?key}):super(key: key);
  @override
  State<ProfilePage> createState()=> _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {

  void _launchURL() async {
    const String urlString = 'https://www.google.com';
    Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $urlString';
    }
  }
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
              onPressed: () {
                Navigator.of(context).pop();  
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
    return Scaffold(
        body:Padding(
          padding: EdgeInsets.symmetric(vertical: 30,horizontal: 30),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex:1,child: Container()),
                    Expanded(flex:5,child: Text('Profile',style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.center,),),
                    Expanded(flex:1,child: IconButton(onPressed: (){_showLogoutDialog(context);}, icon: Icon(Icons.logout),alignment: Alignment.centerRight,)),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Icon(Icons.face_unlock_rounded,size: 130,),
                )
              ),
              Expanded(
                flex: 7,
                child:Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Information Setting',style: Theme.of(context).textTheme.displayMedium),
                              Container(
                                margin: EdgeInsets.only(top:20),
                                color: Color.fromRGBO(118, 118, 128, 0.24),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Personal Information",style: Theme.of(context).textTheme.displaySmall),
                                        Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:5),
                                color: Color.fromRGBO(118, 118, 128, 0.24),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Change Password",style: Theme.of(context).textTheme.displaySmall),
                                        Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('CHAT-GPT method',style: Theme.of(context).textTheme.displayMedium),
                              Container(
                                margin: EdgeInsets.only(top:20),
                                color: Color.fromRGBO(118, 118, 128, 0.24),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("API_KEY",style: Theme.of(context).textTheme.displaySmall),
                                        Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:5),
                                color: Color.fromRGBO(118, 118, 128, 0.24),
                                child: TextButton(
                                    onPressed: (){},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("ACCESS_TOKEN",style: Theme.of(context).textTheme.displaySmall),
                                        Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                      ],
                                    )
                                ),
                              ),

                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Personal Setting',style: Theme.of(context).textTheme.displayMedium),
                              Container(
                                margin: EdgeInsets.only(top:20),
                                color: Color.fromRGBO(118, 118, 128, 0.24),
                                child: TextButton(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Theme Setting",style: Theme.of(context).textTheme.displaySmall),
                                        Icon(Icons.navigate_next_rounded,size: 25,color: Colors.black,)
                                      ],
                                    ),
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
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
                                                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      TextButton(
                                                        child: Container(
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text('System',style: Theme.of(context).textTheme.displayMedium),
                                                                themeProvider.themeMode==ThemeMode.system? Icon(Icons.check):Container()
                                                              ]
                                                          ),
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
                                                              themeProvider.themeMode==ThemeMode.dark? Icon(Icons.check):Container()
                                                            ]
                                                        ),
                                                        onPressed: () => {
                                                          themeProvider.themeMode=ThemeMode.dark,
                                                          Navigator.pop(context),
                                                          print(themeProvider.themeMode)
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text('Light',style: Theme.of(context).textTheme.displayMedium),
                                                              themeProvider.themeMode==ThemeMode.light? Icon(Icons.check):Container()
                                                            ]
                                                        ),
                                                        onPressed: () => {
                                                          themeProvider.themeMode=ThemeMode.light,
                                                          Navigator.pop(context),
                                                          print(themeProvider.themeMode)
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

                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),


            ],
          ) ,

        )
    );
  }
}