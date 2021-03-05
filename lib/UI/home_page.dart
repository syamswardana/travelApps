import 'package:flutter/material.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:travelApps/Objek/activity.dart';
import 'package:travelApps/baseUI/row_plan.dart';

class HomePage {
  static appbar() {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: Colors.white,
      elevation: 0,
      flexibleSpace: Container(
        width: double.infinity,
        height: 65,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                    Text(
                      "27°, Oslo",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Hello Syams",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/crop.jpg",
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  static body(List<Activity> activities) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, right: 20),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
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
                  ? rowPlan(
                      index,
                      activities[index].time,
                      activities[index].activityName,
                      activities[index].place,
                      activities[index].icon,
                      activities[index].done,
                      isFirst: true)
                  : (index == activities.length - 1)
                      ? rowPlan(
                          index,
                          activities[index].time,
                          activities[index].activityName,
                          activities[index].place,
                          activities[index].icon,
                          activities[index].done,
                          isLast: true)
                      : rowPlan(
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
    );
  }
}