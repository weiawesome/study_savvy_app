import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_savvy_app/blocs/provider/theme_provider.dart';
import 'package:study_savvy_app/screens/sign_in.dart';
import 'package:study_savvy_app/screens/sign_up.dart';
import 'package:study_savvy_app/styles/custom_style.dart';


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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpView()));
              },
            )
            )
          ]
        ),
      ),
    
    );
  }
}
