import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/model_plan.dart';
import 'package:travelApps/Objek/plan.dart';
import 'package:travelApps/UI/detail_plan.dart';
import 'package:travelApps/UI/error_page.dart';
import 'package:travelApps/UI/loading_page.dart';
import 'package:travelApps/UI/new_plan_page.dart';

class PlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    // getPlans(user.uid);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Manage Your Plans",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[50],
        padding: EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
            future: ModelPlan.getPlans(user.uid),
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return ErrorPage(
                  msg: snapshot.error,
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingPage();
              } else if (snapshot.connectionState == ConnectionState.done) {
                List<dynamic> docs = snapshot.data;
                List<Plan> _plans = [];
                docs.forEach((doc) {
                  _plans.add(Plan(
                    id: doc.id,
                    startDate: (doc["startDate"] as Timestamp).toDate(),
                    endDate: (doc["endDate"] as Timestamp).toDate(),
                    planName: doc["planName"],
                    thumbnail: null,
                  ));
                });

                return GridView.builder(
                  itemCount: _plans.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.60,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NewPlanPage();
                              }));
                            },
                            child: Center(
                                child: Icon(
                              Icons.add_circle_outline,
                              size: 45,
                              color: Color(0xff3FD4A2),
                            )),
                          ));
                    } else {
                      return InkWell(
                          onTap: () {
                            // print(_plans[index - 1].id);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return DetailPlan(
                                plan: _plans[index - 1],
                              );
                            }));
                          },
                          child: PlanCard(plan: _plans[index - 1]));
                    }
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final Plan plan;
  PlanCard({this.plan});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: plan.thumbnail ?? Image.asset("assets/lighthouse.jpg"),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  plan.planName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Text(
                    "Start date \t: " +
                        DateFormat("dd-mm-yyyy").format(plan.startDate),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "End date \t\t\t: " +
                        DateFormat("dd-mm-yyyy").format(plan.endDate),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
