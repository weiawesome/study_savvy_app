import 'package:flutter/material.dart';
import 'package:study_savvy_app/screens/profile.dart';
import '../widgets/custom_BottomNavagationBar.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key?key}):super(key: key);
  @override
  State<HomePage> createState()=> _HomePage();
}
class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: ProfilePage(),
          bottomNavigationBar:CustomBottomNavigationBar(),
        ),
    );
  }
}