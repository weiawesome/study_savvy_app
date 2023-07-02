import 'package:flutter/material.dart';
import 'package:study_savvy_app/page/sign_in.dart';
import 'package:study_savvy_app/page/sign_up.dart';


void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/initial.jpg'),
          fit: BoxFit.contain,
        )
      ),
      child: HomePage(),
    ),
    );
  }
}

class HomePage extends StatelessWidget {
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
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                  )
                )
                ),
              child: new Text(
                'Sign up',
                style: TextStyle(fontFamily: 'Play', fontSize: 25),
                ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
            ),
          )
  
        ]
      ),
    ),
    );
  }
}