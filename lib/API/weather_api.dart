import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:travelApps/Objek/weather.dart';

class WeatherApi {
  String key = "2b9665ed49bb49eaae479880f8c5babc";

  Future<Position> _determinePosition() async {
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

  static Future<Weather> getWeather(String lat, String long) async {
    String url =
        "https://api.weatherbit.io/v2.0/current?lat=$lat&lon=$long&key=API_KEY";
    var result = await http.post(url);
    var jsonObject = json.decode(result.body);
    return Weather.fromMap(jsonObject);
  }
}
