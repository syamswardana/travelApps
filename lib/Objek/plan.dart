import 'package:flutter/material.dart';

class Plan {
  String id;
  DateTime startDate;
  DateTime endDate;
  String planName;
  Image thumbnail;

  Plan({this.id, this.startDate, this.endDate, this.planName, this.thumbnail});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "startDate": startDate,
      "endDate": endDate,
      "planName": planName,
      "thumbnail": thumbnail
    };
  }
}
