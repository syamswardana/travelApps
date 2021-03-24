import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class RowActivity extends StatelessWidget {
  final int index;
  final DateTime time;
  final String activity;
  final String place;
  final bool isFirst;
  final bool isLast;
  final bool done;
  final int icon;
  RowActivity(
      this.index, this.time, this.activity, this.place, this.icon, this.done,
      {this.isFirst = false, this.isLast = false});
  @override
  Widget build(BuildContext context) {
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
        DateFormat("Hm").format(time),
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
          Icon(
            IconData(icon, fontFamily: 'MaterialIcons'),
            color: Color(0xff3FD4A2),
          ),
        ],
      ),
    );
  }
}
