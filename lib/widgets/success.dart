import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  final String message;
  const Success({Key?key,required this.message}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:30),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle,size: 40,color: Colors.greenAccent,),
          Text(message)
        ],
      ),
    );
  }
}