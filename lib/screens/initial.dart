import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/SignUp/sign_up_event.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';
import 'package:study_savvy_app/screens/sign_in.dart';
import 'package:study_savvy_app/screens/sign_up.dart';
import 'package:study_savvy_app/styles/custom_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';
import 'package:study_savvy_app/utils/routes.dart';

import '../blocs/SignUp/sign_up_bloc.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return  Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              image: DecorationImage(
            image:  (themeProvider.themeMode == ThemeMode.light) || (themeProvider.themeMode == ThemeMode.system)
                ? AssetImage('assets/images/initial_white.jpg')
                : AssetImage('assets/images/initial.jpg'),
            fit: BoxFit.cover,
          )),
      child: Container(
        margin: EdgeInsets.only(top: 400.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            SizedBox(
              width: 189,
              height: 49,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                  elevation: MaterialStateProperty.all(5),
                ),
                child: Text(
                  'Sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                  fontSize: 23,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.bold,
                    ),
                ),
      
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SignInPage()));
                },
              ),
            ),
      
      
            SizedBox(height: 16), // 用于在两个按钮之间添加间距
      
            SizedBox(
              width: 189,
              height: 49,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(themeProvider.themeMode == ThemeMode.dark ? Colors.white : Colors.black),
                  elevation: MaterialStateProperty.all(5),
                ),
                child: Text(
                  'Sign up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  color: themeProvider.themeMode == ThemeMode.dark ? Colors.black : Colors.white,
                  fontSize: 23,
                  fontFamily: 'Play',
                  fontWeight: FontWeight.bold,
                  )
                ),
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUpView()));

                  context.read<SignUpBloc>().add(SignUpEventReset());
                  Navigator.push(context,
                       MaterialPageRoute(builder: (context) => SignUpView()));
                },

              )
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
                Text("一鍵登入(未來會刪除)\n展示如何紀錄jwt 這件事是必要的",style: Theme.of(context).textTheme.displaySmall),
                Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
              ],
            ),
            onPressed: () async {
              JwtService jwtService=JwtService();
              await jwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY5MDMwMzI4MywianRpIjoiOWM2MGQ1NWYtY2MzZi00NzU1LWFiZDEtMjdjMmQ1Y2I0N2QyIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2OTAzMDMyODMsImNzcmYiOiIyNTZhMzcxYy1hYzU5LTRmNWYtODk0OS1jZTU3ODgzYjZhYjYiLCJleHAiOjE2OTE1MTI4ODN9.fVWwqSY84XE0pEv3ZnRuUlXxq1tzHQ5244DEbn0NXTQ").then((value) => context.read<OnlineBloc>().add(OnlineEventCheck()));
            },
          ),
        ]
        )
      )
    );
  }
}
