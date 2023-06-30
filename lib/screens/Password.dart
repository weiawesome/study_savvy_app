import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget{
  const PasswordPage({Key?key}):super(key: key);
  @override
  State<PasswordPage> createState()=> _PasswordPage();
}

class _PasswordPage extends State<PasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}