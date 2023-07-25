import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/profile/bloc_online.dart';
import 'package:study_savvy_app/screens/sign_in.dart';
import 'package:study_savvy_app/screens/sign_up.dart';
import 'package:study_savvy_app/services/utils/jwt_storage.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Container(
      margin: EdgeInsets.only(top: 400.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          SizedBox(
            width: 189,
            height: 49,
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                  )
                )
                ),
              child: new Text(
                'Sign in',
                style: TextStyle(fontFamily: 'Play', fontSize: 25),
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
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ))),
            child: const Text(
              'Sign up',
              style: TextStyle(fontFamily: 'Play', fontSize: 25),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpPage()));
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
                Text("一鍵登入(未來會刪除)",style: Theme.of(context).textTheme.displaySmall),
                Icon(Icons.navigate_next_rounded,size: 25,color: Theme.of(context).hintColor)
              ],
            ),
            onPressed: () async {
              JwtService jwtService=JwtService();
              await jwtService.saveJwt("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY5MDMwMzI4MywianRpIjoiOWM2MGQ1NWYtY2MzZi00NzU1LWFiZDEtMjdjMmQ1Y2I0N2QyIiwidHlwZSI6ImFjY2VzcyIsInN1YiI6IndlaTg5MTAxM0BnbWFpbC5jb20iLCJuYmYiOjE2OTAzMDMyODMsImNzcmYiOiIyNTZhMzcxYy1hYzU5LTRmNWYtODk0OS1jZTU3ODgzYjZhYjYiLCJleHAiOjE2OTE1MTI4ODN9.fVWwqSY84XE0pEv3ZnRuUlXxq1tzHQ5244DEbn0NXTQ").then((value) => context.read<OnlineBloc>().add(OnlineEventCheck()));
            },
          ),
        ]
      ),
    ),
    );
  }
}
