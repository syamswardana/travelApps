import 'package:flutter/material.dart';
import 'package:travelApps/Objek/plan.dart';

class PlanPage {
  static appbar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Text(
        "Manage Your Plans",
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  static body() {
    List<Plan> plans = [];
    plans.add(Plan("12-8-2020", "19-8-2020", "Trip to Oslo",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("25-12-2020", "27-12-2020", "Natalan",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("31-8-2020", "1-1-2021", "New Year Trip",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("12-2-2021", "13-2-2021", "Imlek",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("12-2-2021", "13-2-2021", "Imlek",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("12-2-2021", "13-2-2021", "Imlek",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("12-2-2021", "13-2-2021", "Imlek",
        Image.asset("assets/lighthouse.jpg")));
    plans.add(Plan("12-2-2021", "13-2-2021", "Imlek",
        Image.asset("assets/lighthouse.jpg")));
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey[50],
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: GridView.builder(
        itemCount: plans.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          childAspectRatio: 0.60,
        ),
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: plans[index].thumbnail,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        plans[index].planName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Text(
                          "Start date \t: " + plans[index].startDate,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "End date \t\t\t: " + plans[index].startDate,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
