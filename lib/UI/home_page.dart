import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:travelApps/Objek/activity.dart';
import 'package:travelApps/Objek/weather.dart';
import 'package:travelApps/baseUI/row_activity.dart';

class HomePage extends StatelessWidget {
  final Weather weather;
  final List<Activity> activities;
  HomePage({@required this.activities, @required this.weather});
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          width: double.infinity,
          height: 65,
          margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 7,
                fit: FlexFit.tight,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          weather != null
                              ? Image.network(
                                  "https://www.weatherbit.io/static/img/icons/${weather.icon}.png",
                                  scale: 5,
                                )
                              : Image.asset(
                                  "assets/t01d.png",
                                  scale: 5,
                                ),
                          Text(
                            weather != null
                                ? " ${weather.temp}°, ${weather.city}"
                                : "27°, Surabaya",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        (user.displayName != "")
                            ? "Hello ${user.displayName}"
                            : "Hello ${user.email}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        color: Color(0xff3FD4A2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      (user.displayName != "")
                          ? "${user.displayName.characters.characterAt(0)}"
                          : "${user.email.characters.characterAt(0)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                "Current Trip",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 180,
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      "assets/lighthouse.jpg",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Oslo, Normway",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "DancingScript",
                                    fontSize: 22),
                              ),
                              Text(
                                " 3 days more",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                          RaisedButton(
                            onPressed: () {
                              print("home : " +
                                  AuthServices.firebaseUserStream.toString());
                            },
                            child: Text(
                              "Manage",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Color(0xff3FD4A2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Trip Plan",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: false,
              physics: ScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return (index == 0)
                    ? RowActivity(
                        index,
                        activities[index].time,
                        activities[index].activityName,
                        activities[index].place,
                        activities[index].icon,
                        activities[index].done,
                        isFirst: true)
                    : (index == activities.length - 1)
                        ? RowActivity(
                            index,
                            activities[index].time,
                            activities[index].activityName,
                            activities[index].place,
                            activities[index].icon,
                            activities[index].done,
                            isLast: true)
                        : RowActivity(
                            index,
                            activities[index].time,
                            activities[index].activityName,
                            activities[index].place,
                            activities[index].icon,
                            activities[index].done);
              },
            ))
          ],
        ),
      ),
    );
  }
}
