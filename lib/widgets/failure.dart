import 'package:flutter/material.dart';

class Failure extends StatelessWidget {
  final String error;
  const Failure({Key?key,required this.error}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:30),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline,size: 40,color: Colors.red,),
          Text(error)
        ],
      ),
    );
  }
}