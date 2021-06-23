import 'package:school_app_example/CalendarEvent/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> appointments) {
    this.appointments = appointments;
  }

  Event getEvent(int index) => appointments![index] as Event;

  DateTime getStartTime(int index) =>getEvent(index).from;

  DateTime getEndTime(int index) =>getEvent(index).to;

  String getSubject(int index) => getEvent(index).title;

  Color getColor(int index) => getEvent(index).backgroundColor;

  bool isAllDay(int index) => getEvent(index).isAllDay;

}