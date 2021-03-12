import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:travelApps/Objek/place.dart';
import 'package:http/http.dart' as http;
import 'package:travelApps/Objek/place_prediction.dart';

class PlaceApi {
  static String _key = "AIzaSyCXiRQ0oKsO6TjvoMuDo9oXFGJu2fJ0usA";

  static Future<List<Place>> getPopularPlaces(
      {@required double lat,
      @required double long,
      String type = "tourist_attraction"}) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=50000&type=$type&keyword=popular&key=$_key";
    var result = await http.post(url);
    var jsonObject = json.decode(result.body);
    List<Place> places = [];
    for (var place in jsonObject["results"]) {
      places.add(Place.fromMap(place));
    }
    return places;
  }

  static Future<Place> getPlaceDetails(String id) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$id&key=$_key";
    var result = await http.post(url);
    var jsonObject = json.decode(result.body);
    return Place.fromMap(jsonObject["result"]);
  }

  static NetworkImage getImage(String references) {
    return NetworkImage(
        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=720&photoreference=$references&key=$_key");
  }

  static Future<List<PlacePrediction>> getPredictions(String input) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_key&components=country:id&sessiontoken=1234567890";
    var result = await http.get(url);
    var jsonObject = json.decode(result.body);
    List<PlacePrediction> predictions = [];
    for (var place in jsonObject["predictions"]) {
      predictions.add(PlacePrediction.fromMap(place));
    }
    return predictions;
  }
}
