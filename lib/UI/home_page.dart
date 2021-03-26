import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/model_activity.dart';
import 'package:travelApps/Objek/activity.dart';
import 'package:travelApps/Objek/plan.dart';
import 'package:travelApps/Objek/weather.dart';
import 'package:travelApps/UI/detail_plan.dart';
import 'package:travelApps/UI/error_page.dart';
import 'package:travelApps/UI/loading_page.dart';
import 'package:travelApps/UI/new_plan_page.dart';
import 'package:travelApps/baseUI/row_activity.dart';
import 'package:travelApps/bloc/plans_bloc.dart';

class HomePage extends StatelessWidget {
  final Weather weather;
  HomePage({@required this.weather});
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    context.read<PlansBloc>().add(RefreshPlans(uid: user.uid));

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
                        (user.displayName != null)
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
                    decoration: BoxDecoration(
                        color: Color(0xff3FD4A2),
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      (user.displayName != null)
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
      body: BlocBuilder<PlansBloc, PlansState>(
        builder: (context, state) {
          List<Plan> plans = [];
          List<Plan> plansToday = [];
          List<String> plansId = [];
          DateTime now = DateTime.now();
          DateTime today = DateTime(now.year, now.month, now.day);
          DateTime tommorow = DateTime(now.year, now.month, now.day);
          if (state is PlansInitial) {
            return LoadingPage();
          } else if (state is PlansError) {
            return ErrorPage(
              msg: "error",
            );
          } else if (state is PlansLoaded) {
            plans = state.plans ?? [];
            plans.forEach((plan) {
              plansId.add(plan.id);
            });
          }
          for (Plan plan in plans) {
            if (plan.startDate.isAtSameMomentAs(today) ||
                plan.endDate.isAtSameMomentAs(today)) {
              plansToday.add(plan);
            } else if (today.isAfter(plan.startDate) &&
                today.isBefore(plan.endDate)) {
              plansToday.add(plan);
            }
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Current Plan",
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
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (plansToday.length != 0)
                            ? Image.asset(
                                "assets/lighthouse.jpg",
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                              )
                            : SvgPicture.asset("assets/svg_options.svg"),
                      ),
                      (plansToday.length != 0)
                          ? Container()
                          : Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin: EdgeInsets.all(15),
                                  child: Text(
                                    "No plan today",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              (plansToday.length != 0)
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          plansToday[0].planName,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "DancingScript",
                                              fontSize: 22),
                                        ),
                                        Text(
                                          plansToday[0]
                                                  .endDate
                                                  .difference(today)
                                                  .inDays
                                                  .toString() +
                                              " days more",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    )
                                  : RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (contexxt) {
                                          return NewPlanPage();
                                        }));
                                      },
                                      child: Text(
                                        "Create plan",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Color(0xff3FD4A2),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                              RaisedButton(
                                onPressed: () {
                                  if (plansToday.length != 0) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return DetailPlan(
                                        plan: plansToday[0],
                                      );
                                    }));
                                  } else {}
                                },
                                child: Text(
                                  (plansToday.length != 0)
                                      ? "Manage"
                                      : "Explore",
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
                    "Activities Plan",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: (plansId.length == 0)
                        ? Center(
                            child: Text("No plan"),
                          )
                        : FutureBuilder(
                            future: ModelActivity.getAllActivities(plansId),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return ErrorPage(
                                  msg: "Error connection",
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return LoadingPage();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text("No Activities"),
                                  );
                                }
                              }

                              List<QueryDocumentSnapshot> docs = snapshot.data;
                              List<Activity> activities = [];
                              docs.forEach((doc) {
                                DateTime time =
                                    (doc["time"] as Timestamp).toDate();
                                activities.add(Activity(
                                    id: doc.id,
                                    activityName: doc["activityName"],
                                    done: (DateTime.now()
                                            .difference(time)
                                            .inMinutes >
                                        0),
                                    icon: doc["icon"],
                                    place: doc["place"],
                                    planId: doc["planId"],
                                    time: time));
                              });
                              if (activities.length == 0) {
                                return Center(
                                  child: Text("No activities today"),
                                );
                              }
                              return ListView.builder(
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
                              );
                            }))
              ],
            ),
          );
        },
      ),
    );
  }
}
