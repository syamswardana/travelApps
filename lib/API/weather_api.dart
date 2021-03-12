import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:travelApps/Objek/weather.dart';

class WeatherApi {
  static String _key = "8be88ac344ce45ae97776e7066458d8c";

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  static Future<Weather> getWeather(String lat, String lon) async {
    String url =
        "https://api.weatherbit.io/v2.0/current?lat=$lat&lon=$lon&key=$_key";
    var result = await http.post(url);
    var jsonObject = json.decode(result.body);
    return Weather.fromMap(jsonObject);
  }
}
