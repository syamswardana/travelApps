import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/model_activity.dart';
import 'package:travelApps/Firebase/model_plan.dart';
import 'package:travelApps/Objek/activity.dart';
import 'package:travelApps/Objek/plan.dart';
import 'package:travelApps/bloc/activitiescrud_bloc.dart';
import 'package:travelApps/baseUI/row_activity.dart';
import 'package:travelApps/bloc/plans_bloc.dart';

class AddDayPage extends StatefulWidget {
  final DateTime startDate, endDate;
  final String planName;
  AddDayPage(
      {@required this.startDate,
      @required this.endDate,
      @required this.planName});

  @override
  _AddDayPageState createState() => _AddDayPageState(
      startDate: startDate, endDate: endDate, planName: planName);
}

class _AddDayPageState extends State<AddDayPage> {
  final DateTime startDate, endDate;
  final String planName;
  _AddDayPageState({@required this.startDate, this.endDate, this.planName});

  List<DateTime> days = [];

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _timeController = TextEditingController();
  TextEditingController _activityController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  String msgActivity = "";
  String msgPlace = "";
  List<Activity> activities;
  IconData icon = Icons.pool;

  @override
  void initState() {
    _timeController.text = DateFormat("Hm")
        .format(DateTime(startDate.year, startDate.month, startDate.day));
    int numDays =
        (endDate != null) ? endDate.difference(startDate).inDays + 1 : 1;
    for (var i = 0; i < numDays; i++) {
      DateTime tempDate = startDate.add(new Duration(days: i));
      days.add(tempDate);
    }
    super.initState();
  }

  Future<Null> _selectTime(BuildContext context, DateTime date) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _timeController.text = DateFormat("Hm").format(DateTime(date.year,
            date.month, date.day, selectedTime.hour, selectedTime.minute));
      });
  }

  Future<bool> _onWillPop() async {
    // if (context.read<ActivitiesCrudBloc>().state is ActivitiesCrudLoaded) {
    //   context.read<ActivitiesCrudBloc>().add(SetToNull());
    // }
    // Navigator.pop(context);
    return true;
  }

  Future<void> _chooseIcon() async {
    switch (await showDialog<IconData>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 200,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Choose Icon",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount: 5,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.pool,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.pool;
                              Navigator.pop(context, Icons.pool);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.fastfood,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.fastfood;
                              Navigator.pop(context, Icons.fastfood);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.shopping_bag,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.shopping_bag;
                              Navigator.pop(context, Icons.shopping_bag);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.movie,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.movie;
                              Navigator.pop(context, Icons.movie);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.camera_alt_outlined;
                              Navigator.pop(context, Icons.camera_alt_outlined);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.agriculture_rounded,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.agriculture_rounded;
                              Navigator.pop(context, Icons.agriculture_rounded);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.airline_seat_flat,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.airline_seat_flat;
                              Navigator.pop(context, Icons.airline_seat_flat);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.airplanemode_active,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.airplanemode_active;
                              Navigator.pop(context, Icons.airplanemode_active);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.airport_shuttle,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.airport_shuttle;
                              Navigator.pop(context, Icons.airport_shuttle);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.auto_stories,
                              color: Color(0xff3FD4A2),
                            ),
                            onPressed: () {
                              icon = Icons.auto_stories;
                              Navigator.pop(context, Icons.auto_stories);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })) {
      case null:
        break;
      default:
        setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textTab = new TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle subTab = new TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: days.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                if (context.read<ActivitiesCrudBloc>().state
                    is ActivitiesCrudLoaded) {
                  context.read<ActivitiesCrudBloc>().add(SetToNull());
                }
                Navigator.pop(context);
              },
            ),
            elevation: 0,
            title: Text(
              "Add day plans",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Color(0xff3FD4A2),
              tabs: List<Widget>.generate(days.length, (index) {
                DateTime day = days[index];
                String date = DateFormat("MMMM d").format(day);
                return Tab(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      date,
                      style: subTab,
                    ),
                  ),
                  icon: Text(
                    "Day ${index + 1}",
                    style: textTab,
                  ),
                );
              }),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FlatButton(
            minWidth: MediaQuery.of(context).size.width - 40,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            color: Color(0xff3FD4A2),
            onPressed: () async {
              User user = Provider.of<User>(context, listen: false);
              Plan plan = new Plan(
                  id: null,
                  startDate: startDate,
                  endDate: endDate,
                  planName: planName,
                  thumbnail: null);
              await ModelPlan.addPlan(plan.toMap(), user.uid).then((value) {
                for (var activity in activities) {
                  activity.planId = value.id;
                  ModelActivity.addActivity(activity.toMap());
                }
              });
              if (context.read<ActivitiesCrudBloc>().state
                  is ActivitiesCrudLoaded) {
                context.read<ActivitiesCrudBloc>().add(SetToNull());
              }
              context.read<PlansBloc>().add(RefreshPlans(uid: user.uid));
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          body: BlocBuilder<ActivitiesCrudBloc, ActivitiesCrudState>(
            builder: (context, state) {
              activities = (state is ActivitiesCrudInitial)
                  ? []
                  : (state as ActivitiesCrudLoaded).activities;
              return TabBarView(
                  children: List<Widget>.generate(days.length, (index) {
                List<Activity> activitiesDay = [];
                for (var activity in activities) {
                  if (activity.time.day == days[index].day)
                    activitiesDay.add(activity);
                }
                activitiesDay.sort((a, b) {
                  return a.time.compareTo(b.time);
                });
                return Container(
                  padding: EdgeInsets.all(20),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              _selectTime(context, days[index]);
                            },
                            child: Container(
                              height: 40,
                              width: 100,
                              child: TextFormField(
                                enabled: false,
                                controller: _timeController,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    prefixIcon: Icon(
                                      Icons.access_time,
                                      color: Color(0xff3FD4A2),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                height: 40,
                                padding: EdgeInsets.only(left: 25),
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _activityController,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          return (msgActivity != null ||
                                                  msgActivity != "")
                                              ? msgActivity
                                              : null;
                                        },
                                        onChanged: (value) {
                                          if (value != null || value != "") {
                                            msgActivity = null;
                                          }
                                        },
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15),
                                            border: InputBorder.none,
                                            hintText: "Activity",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black)),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        icon,
                                        size: 20,
                                        color: Color(0xff3FD4A2),
                                      ),
                                      onPressed: () {
                                        _chooseIcon();
                                      },
                                    )
                                  ],
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 40,
                              child: TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: _placeController,
                                style: TextStyle(fontSize: 14),
                                validator: (value) {
                                  return (msgPlace != null || msgPlace != "")
                                      ? msgPlace
                                      : null;
                                },
                                onChanged: (value) {
                                  if (value != null || value != "") {
                                    msgPlace = null;
                                  }
                                },
                                decoration: InputDecoration(
                                    hintText: "Place",
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 120,
                            child: FlatButton(
                              onPressed: () {
                                if (_activityController.text != "" &&
                                    _placeController.text != "") {
                                  DateTime time = DateTime(
                                      days[index].year,
                                      days[index].month,
                                      days[index].day,
                                      selectedTime.hour,
                                      selectedTime.minute);
                                  Activity activity = new Activity(
                                      activityName: _activityController.text,
                                      time: time,
                                      place: _placeController.text,
                                      icon: icon.codePoint);

                                  context
                                      .read<ActivitiesCrudBloc>()
                                      .add(AddActivity(activity: activity));
                                  _activityController.text = "";
                                  _placeController.text = "";
                                } else {
                                  if (_activityController.text == "") {
                                    msgActivity = "Fill activity name";
                                  }
                                  if (_placeController.text == "") {
                                    msgPlace = "Fill place name";
                                  }
                                  setState(() {});
                                }
                              },
                              color: Color(0xffDEF4ED),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              minWidth: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Add activity",
                                  style: TextStyle(
                                      color: Color(0xff3FD4A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 30,
                      ),
                      Expanded(
                        child: (activitiesDay == null)
                            ? Container()
                            : ListView.builder(
                                itemCount: activitiesDay.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: RowActivity(
                                            index,
                                            activitiesDay[index].time,
                                            activitiesDay[index].activityName,
                                            activitiesDay[index].place,
                                            activitiesDay[index].icon,
                                            false),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          context
                                              .read<ActivitiesCrudBloc>()
                                              .add(
                                                  DeleteActivity(index: index));
                                        },
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                );
              }));
            },
          ),
        ),
      ),
    );
  }
}
