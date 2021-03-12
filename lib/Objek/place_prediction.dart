import 'package:flutter/cupertino.dart';

class PlacePrediction {
  String description;
  int distance;
  String placeId;

  PlacePrediction(
      {@required this.description,
      @required this.distance,
      @required this.placeId});

  factory PlacePrediction.fromMap(Map<String, dynamic> map) {
    return PlacePrediction(
        description: map["description"],
        distance: map["distance_meters"],
        placeId: map["place_id"]);
  }
}
