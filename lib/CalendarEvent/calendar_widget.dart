import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_app_example/CalendarEvent/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:school_app_example/CalendarEvent/event_editing_page.dart';
import 'package:school_app_example/CalendarEvent/event_data_source.dart';

class CalendarWidget extends StatelessWidget {

  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      monthViewSettings:  MonthViewSettings(showAgenda: true),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
    );
  }
}