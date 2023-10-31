import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/utils/bloc_navigator.dart';
import 'package:study_savvy_app/widgets/custom_navigate.dart';

class MenuHome extends StatefulWidget{
  const MenuHome({Key?key}):super(key: key);
  @override
  State<MenuHome> createState()=> _HomePage();
}
class _HomePage extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<PageBloc, PageState>(
          builder: (context, state) {
            return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  child:  pageWidgets[state]??Container(),
            ));
          }
      ),
      bottomNavigationBar:const CustomNavigate(),
    );
  }
}