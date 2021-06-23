import 'package:flutter/material.dart';
import 'package:school_app_example/CalendarEvent/event_editing_page.dart';

class Event{
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    this.backgroundColor = Colors.blueAccent, //イベントのバックカラー
    this.isAllDay = false,
  });
}