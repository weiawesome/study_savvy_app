import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/bloc_navigator.dart';
import '../widgets/custom_BottomNavigationBar.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key?key}):super(key: key);
  @override
  State<HomePage> createState()=> _HomePage();
}
class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<PageBloc, PageState>(
          builder: (context, state) {
            return SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child:  pageWidgets[state]??Container(),
            ));
          }
      ),
      bottomNavigationBar:CustomBottomNavigationBar(),
    );
  }
}