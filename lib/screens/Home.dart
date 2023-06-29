import 'package:flutter/material.dart';
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
    return SafeArea(
        child: Scaffold(
          body: BlocBuilder<PageBloc, PageState>(
            builder: (context, state) {
              return pageWidgets[state]??Container();
            }
          ),
          bottomNavigationBar:CustomBottomNavigationBar(),
        ),
    );
  }
}