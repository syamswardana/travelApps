import 'package:flutter/material.dart';

class Activity {
  String time;
  String activityName;
  String place;
  bool done;
  Icon icon;

  Activity(this.time, this.activityName, this.place, this.icon,
      [this.done = false]);
}
