import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我是 B 頁'),
      ),
      body: _SignUpPage(),
    );
  }
}

class _SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('返回首頁'),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}