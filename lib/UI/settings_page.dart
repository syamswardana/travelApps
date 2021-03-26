import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/auth_services.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
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
              Container(
                alignment: Alignment.center,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff3FD4A2)),
                child: Text(
                  (user.displayName != null)
                      ? "${user.displayName.characters.characterAt(0)}"
                      : "${user.email.characters.characterAt(0)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  softWrap: true,
                ),
              ),
              (user.displayName != null) ? user.displayName : user.email,
              (user.displayName != null) ? user.email : "Freelancer",
              RaisedButton(
                child: Text(
                  "Edit",
                  style: TextStyle(color: Color(0xff3FD4A2), fontSize: 12),
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
                    softWrap: true,
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
