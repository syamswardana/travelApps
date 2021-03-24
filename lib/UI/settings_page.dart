import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:travelApps/Firebase/auth_services.dart';

class SettingsPage extends StatelessWidget {
  bool _switchPermission = false;
  Future<void> changePermission() async {
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
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        _switchPermission = true;
      }
    } else {
      // LocationPermission.denied;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Your Preferences",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: ListView(children: [
          listSetting(
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                  "assets/crop.jpg",
                ),
              ),
              "Syams",
              "Programmer",
              RaisedButton(
                child: Text(
                  "Edit profile",
                  style: TextStyle(color: Color(0xff3FD4A2)),
                ),
                onPressed: () {},
                color: Color(0xffE2F9F1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              )),
          // listSetting(
          //   Icon(Icons.location_on),
          //   "Location Permission",
          //   "Switch to change permission",
          //   Switch(
          //     value: _switchPermission,
          //     onChanged: (bool value) {
          //       changePermission();
          //     },
          //   ),
          //   true,
          // ),
          listSetting(
              //payment
              Icon(Icons.account_balance_wallet),
              "Payment methods",
              "Manage your card",
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                child: Icon(Icons.arrow_forward),
              ),
              true),
          listSetting(
              //discount
              Icon(Icons.confirmation_number_rounded),
              "Discounts",
              "Check out your discounts",
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                child: Icon(Icons.arrow_forward),
              ),
              true),
          listSetting(
              //Notifications
              Icon(Icons.notifications),
              "Notifications",
              "Notification preferences",
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                child: Icon(Icons.arrow_forward),
              ),
              true),
          listSetting(
              //time zone
              Icon(Icons.access_time_rounded),
              "Time Zone",
              "Change your time zone",
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                elevation: 0,
                child: Icon(Icons.arrow_forward),
              ),
              true),
          InkWell(
              onTap: () async {
                await AuthServices.signOut();
                // Navigator.pushReplacement(context,
                //     MaterialPageRoute(builder: (context) {
                //   return Wrapper();
                // }));
              },
              child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.only(right: 25),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red,
                        )),
                    Text("Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  Container listSetting(
      Widget icon, String title, String subtitle, Widget button,
      [bool kecil = false]) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.2, color: Colors.black))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey[100]),
                margin: EdgeInsets.only(right: 25),
                child: icon,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: (!kecil) ? 18 : 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                        color: Colors.grey, fontSize: (!kecil) ? 14 : 12),
                  )
                ],
              ),
            ],
          ),
          button
        ],
      ),
    );
  }
}
