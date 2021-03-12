import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Place {
  String placeId;
  String name;
  bool openNow;
  int photoHeight;
  int photoWidth;
  String photoReferences;
  List<dynamic> types;
  dynamic rating;
  String vicinity;
  String formattedAddress;
  List<dynamic> reviews;
  Place(
      {@required this.placeId,
      @required this.name,
      @required this.openNow,
      @required this.photoHeight,
      @required this.photoWidth,
      @required this.photoReferences,
      @required this.types,
      @required this.rating,
      @required this.vicinity,
      this.formattedAddress,
      this.reviews});

  factory Place.fromMap(Map<String, dynamic> map) {
    List<dynamic> photos = map["photos"];
    Map<String, dynamic> photo = photos[0];
    return Place(
        placeId: map["place_id"],
        name: map["name"],
        openNow: false,
        photoHeight: photo["height"],
        photoWidth: photo["width"],
        photoReferences: photo["photo_reference"],
        types: map["types"],
        rating: (map["rating"] is int)
            ? double.parse(map["rating"].toString() + ".0")
            : map["rating"],
        vicinity: map["vicinity"] ?? "Town Center",
        formattedAddress: map["formatted_address"] ?? null,
        reviews: map["reviews"] ?? null);
  }
}
