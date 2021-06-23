

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app_example/routes/Calendar_route.dart';
import 'package:school_app_example/routes/Homework_route.dart';
import 'package:school_app_example/routes/Schoolbook_route.dart';
import 'package:school_app_example/routes/Home_route.dart';

class RootWidget extends StatefulWidget {
  RootWidget({Key? key}) : super(key: key);

  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {

  int _selectedIndex = 0;
  final _bottomNavigationBarItems = <BottomNavigationBarItem>[];

  static const _footerIcons = [
    Icons.home,
    Icons.calendar_today_sharp,
    Icons.book,
    Icons.home_work_outlined,
  ];


  static const _footerItemNames = [
    'Home',
    'Plan',
    'Note',
    'Q&A',
  ];

  var _routes = [
    Home(),
    Calendar(),
    Book(),
    Homework(),
  ];

  void initState() {
    super.initState();
    _bottomNavigationBarItems.add(_UpdateActiveState(0));
    for(var i=1; i<_footerItemNames.length; i++){
      _bottomNavigationBarItems.add(_UpdateDeactiveState(i));
    }
  }


  BottomNavigationBarItem _UpdateActiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black87,
        ),
        title: Text(
          _footerItemNames[index],
          style: TextStyle(
            color: Colors.black87,
          ),
        )
    );
  }

  BottomNavigationBarItem _UpdateDeactiveState(int index) {
    return BottomNavigationBarItem(
        icon: Icon(
          _footerIcons[index],
          color: Colors.black26,
        ),
        title: Text(
          _footerItemNames[index],
          style:  TextStyle(
            color: Colors.black26,
          ),
        )
    );
  }

  void _onItemTapped(int index) {
    setState((){
      _bottomNavigationBarItems[_selectedIndex] = _UpdateDeactiveState(_selectedIndex);
      _bottomNavigationBarItems[index] = _UpdateActiveState(index);
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}