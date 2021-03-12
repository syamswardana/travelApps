import 'package:flutter/material.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:travelApps/UI/wrapper.dart';

class SettingsPage extends StatelessWidget {
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
          ),
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
          ),
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
          ),
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
          ),
          InkWell(
              onTap: () async {
                await AuthServices.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Wrapper();
                }));
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
                          fontSize: 18,
                        )),
                  ],
                ),
              ))
        ]),
      ),
    );
  }

  Container listSetting(
      Widget icon, String title, String subtitle, Widget button) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
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
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
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
