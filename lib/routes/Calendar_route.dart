import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app_example/CalendarEvent/calendar_widget.dart';
import 'package:school_app_example/CalendarEvent/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:school_app_example/CalendarEvent/event_editing_page.dart';

class Calendar extends StatelessWidget {
  static final String title = 'Calendar & Memo';

  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calendar',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          accentColor: Colors.white,
          primaryColor: Colors.red,
        ),
        home: CalendarPage(),
      )
  );
}

class CalendarPage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("予定表"),
      centerTitle: true,
    ),
    body: CalendarWidget(),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add, color: Colors.red),
      backgroundColor: Colors.white,
      onPressed: () =>
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
    ),
  );
}