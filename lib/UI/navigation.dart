import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelApps/API/place_api.dart';
import 'package:travelApps/API/weather_api.dart';
import 'package:travelApps/Objek/activity.dart';
import 'package:travelApps/Objek/place.dart';
import 'package:travelApps/Objek/weather.dart';
import 'package:travelApps/UI/explore_page.dart';
import 'package:travelApps/UI/home_page.dart';
import 'package:travelApps/UI/plan_page.dart';
import 'package:travelApps/UI/settings_page.dart';
import 'package:travelApps/baseUI/row_plan.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  List<Activity> _activity = [];
  List<Widget> _baris = [];
  List<Place> _places = [];
  Weather _weather;

  _NavigationState() {
    _activity.add(new Activity(
        "08.30",
        "Breakfast",
        "Warung padang",
        Icon(
          Icons.fastfood,
          color: Color(0xff3FD4A2),
        ),
        true));
    _activity.add(new Activity(
        "10.00",
        "Swiming",
        "Waterboom Boomer",
        Icon(
          Icons.pool,
          color: Color(0xff3FD4A2),
        )));
    _activity.add(new Activity(
        "08.30",
        "Shoping",
        "Matahari",
        Icon(
          Icons.shopping_bag,
          color: Color(0xff3FD4A2),
        )));
    _activity.add(new Activity(
        "08.30",
        "Shoping",
        "Matahari",
        Icon(
          Icons.shopping_bag,
          color: Color(0xff3FD4A2),
        )));
    _activity.add(new Activity(
        "08.30",
        "Shoping",
        "Matahari",
        Icon(
          Icons.shopping_bag,
          color: Color(0xff3FD4A2),
        )));
    for (int i = 0; i < _activity.length; i++) {
      Activity activity = _activity[i];
      _baris.add(rowPlan(i, activity.time, activity.activityName,
          activity.place, activity.icon, activity.done));
    }
    WeatherApi.determinePosition().then((posisition) {
      WeatherApi.getWeather(
              posisition.latitude.toString(), posisition.longitude.toString())
          .then((weather) {
        _weather = weather;
        setState(() {});
      });
      PlaceApi.getPopularPlaces(
              lat: posisition.latitude, long: posisition.longitude)
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
          ? HomePage(weather: _weather, activities: _activity)
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
