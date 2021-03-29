import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelApps/API/place_api.dart';
import 'package:travelApps/API/weather_api.dart';
import 'package:travelApps/Objek/place.dart';
import 'package:travelApps/Objek/weather.dart';
import 'package:travelApps/UI/explore_page.dart';
import 'package:travelApps/UI/home_page.dart';
import 'package:travelApps/UI/plan_page.dart';
import 'package:travelApps/UI/settings_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Place> _places = [];
  Weather _weather;

  _NavigationState() {
    WeatherApi.determinePosition().then((position) {
      WeatherApi.getWeather(
              position.latitude.toString(), position.longitude.toString())
          .then((weather) {
        _weather = weather;
        setState(() {});
      });
      PlaceApi.getPopularPlaces(
              lat: position.latitude, long: position.longitude)
          .then((places) {
        _places = places;
        setState(() {});
      });
    }).catchError((error) {
      Position pos = Position(latitude: -7.4884744, longitude: 112.6588699);
      WeatherApi.getWeather(pos.latitude.toString(), pos.longitude.toString())
          .then((weather) {
        _weather = weather;
        setState(() {});
      });
      PlaceApi.getPopularPlaces(lat: pos.latitude, long: pos.longitude)
          .then((places) {
        _places = places;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: (_selectedIndex == 0)
          ? HomePage(weather: _weather)
          : (_selectedIndex == 1)
              ? PlanPage()
              : (_selectedIndex == 2)
                  ? ExplorePage(
                      places: _places,
                    )
                  : SettingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            label: "Plan",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
            ),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: "Settings",
          )
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff3FD4A2),
      ),
    );
  }
}
