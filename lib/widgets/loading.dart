import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key?key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:30),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Theme.of(context).hintColor,
      ),
    );
  }
}