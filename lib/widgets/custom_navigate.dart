import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_savvy_app/blocs/bloc_navigator.dart';

class CustomNavigate extends StatefulWidget {
  const CustomNavigate({super.key});

  @override
  State<CustomNavigate> createState() => _CustomNavigate();
}

class _CustomNavigate extends State<CustomNavigate> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.feed_outlined,size: 38,),
          activeIcon: Icon(Icons.feed_outlined,size: 38,),
          label: 'Note Maker',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mode_edit_outline_outlined,size: 38),
          activeIcon: Icon(Icons.mode_edit_outline_outlined,size: 38),
          label: 'Writing Improver',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time,size: 38),
          activeIcon: Icon(Icons.access_time,size: 38),
          label: 'Files',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person,size: 38),
          activeIcon: Icon(Icons.person,size: 38),
          label: 'Profile',
        ),
      ],

      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).brightness== Brightness.dark?const Color.fromRGBO(217,217,217,1):Colors.black,
      unselectedItemColor: const Color.fromRGBO(118,118,118,1),
      onTap: (index) {
        context.read<PageBloc>().add(pageEvents[index]);
      },
      currentIndex: pageIndex[context.watch<PageBloc>().state]??0,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    );
  }
}
