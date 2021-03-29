import 'package:cloud_firestore/cloud_firestore.dart';

class Activity {
  String id;
  String planId;
  DateTime time;
  String activityName;
  String place;
  bool done;
  int icon;

  Activity(
      {this.id,
      this.planId,
      this.time,
      this.activityName,
      this.place,
      this.icon,
      this.done = false});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "planId": planId,
      "time": time,
      "activityName": activityName,
      "place": place,
      "icon": icon,
      "done": done
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      activityName: map["activityName"],
      done: false,
      id: map["id"] ?? null,
      icon: map["icon"],
      place: map["place"],
      planId: map["planId"],
      time: (map['time'] as Timestamp).toDate(),
    );
  }
}
