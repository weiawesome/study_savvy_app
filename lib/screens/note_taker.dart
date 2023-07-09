import 'package:flutter/material.dart';

class NoteTakerPage extends StatefulWidget {
  const NoteTakerPage({super.key});

  @override
  State<NoteTakerPage> createState() => _NoteTakerPageState();
}

class _NoteTakerPageState extends State<NoteTakerPage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Color(0xFF202124);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        fontFamily: 'Play',
        appBarTheme: AppBarTheme(
          color: primaryColor,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'StudySavvy',
            style: TextStyle(
              //fontFamily: 'Play',
              fontSize: 36.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          //automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },),
        ),
        body: Container(
          color: primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ), 
        ),
      ),
    ));
  }
}