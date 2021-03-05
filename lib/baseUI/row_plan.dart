import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

TimelineTile rowPlan(
    int index, String time, String activity, String place, Icon icon, bool done,
    {bool isFirst = false, bool isLast = false}) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    isFirst: (isFirst == true) ? true : false,
    isLast: (isLast == true) ? true : false,
    lineXY: 0.23,
    beforeLineStyle:
        LineStyle(color: (done == true) ? Color(0xff3FD4A2) : Colors.grey),
    afterLineStyle:
        LineStyle(color: (done == true) ? Color(0xff3FD4A2) : Colors.grey),
    indicatorStyle: IndicatorStyle(
      indicator: Container(
        decoration: BoxDecoration(
            color: (done == true) ? Color(0xff3FD4A2) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
                color: (done == true) ? Color(0xff3FD4A2) : Colors.grey)),
        child: (done == true)
            ? Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              )
            : null,
      ),
    ),
    startChild: Text(
      time,
      style: TextStyle(fontSize: 16),
    ),
    endChild: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                place,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ),
        icon
      ],
    ),
  );
}
