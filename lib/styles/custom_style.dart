// lib/styles/custom_style.dart
import 'package:flutter/material.dart';

class LightStyle {
  static const MaterialColor primarySwatch = Colors.blue;
  static const Color primaryLight = Color(0xFFFBFCFF);
  static BoxDecoration boxDecoration= BoxDecoration(
    border: Border.all(
      color: const Color(0xFF3D3D3D),
      width: 1,
    ),
  );
  static const Color FileBoxColor= Color.fromRGBO(236, 236, 236, 0.80);

  static final ThemeData theme = ThemeData(
    primarySwatch: primarySwatch,
    primaryColor: primaryLight,
    brightness: Brightness.light,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize:36,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.grey[400], fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.black, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.black, fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: Colors.black, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        elevation: MaterialStateProperty.all(5),
      ),
    ),
  );
}

class DarkStyle {
  static const MaterialColor primarySwatch = Colors.blue;
  static const Color primaryDark = Color(0xFF202124);
  static const BoxDecoration boxDecoration= BoxDecoration(color: Color.fromRGBO(118, 118, 128, 0.24));
  static const Color FileBoxColor= Colors.black;
  static final ThemeData theme = ThemeData(
    primaryColor: primaryDark,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize:36,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white, fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      bodySmall: TextStyle(color: Colors.white, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: Colors.white, fontSize:24,fontFamily: 'Play',fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: Colors.white, fontSize:17,fontFamily: 'Play',fontWeight: FontWeight.bold),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(51, 71, 250, 0.78)),
        elevation: MaterialStateProperty.all(5),
      ),
    ),
  );
}
