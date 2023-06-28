import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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

      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Theme.of(context).brightness== Brightness.dark?Color.fromRGBO(217,217,217,1):Colors.black,
      unselectedItemColor: Color.fromRGBO(118,118,118,1),
      onTap: _onItemTapped,
      currentIndex: _selectedIndex,
    );
  }
}
