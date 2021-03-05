import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class AddDayPage extends StatefulWidget {
  @override
  _AddDayPageState createState() => _AddDayPageState();
}

class _AddDayPageState extends State<AddDayPage> {
  // double _height;
  // double _width;

  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  // TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textTab = new TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    TextStyle subTab = new TextStyle(
      color: Colors.grey,
      fontSize: 16,
    );

    int listday = 4;
    return DefaultTabController(
      length: listday,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {},
          ),
          elevation: 0,
          toolbarHeight: 160,
          title: Text(
            "Add day plans",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Color(0xff3FD4A2),
            tabs: List<Widget>.generate(listday, (index) {
              String day = (index + 1).toString();
              return SizedBox(
                height: 70,
                child: Tab(
                    child: Container(
                  margin: EdgeInsets.only(left: 27.5, right: 27.5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Day $day",
                        style: textTab,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Maret $day",
                        style: subTab,
                      )
                    ],
                  ),
                )),
              );
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FlatButton(
          height: 60,
          minWidth: MediaQuery.of(context).size.width - 40,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Text(
            "Next step",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          color: Color(0xff3FD4A2),
          onPressed: () {},
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            width: 145,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              textAlignVertical: TextAlignVertical.center,
                              onSaved: (String val) {
                                _setTime = val;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.access_time_outlined),
                                  disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide.none),
                                  // labelText: 'Time',
                                  contentPadding: EdgeInsets.all(5)),
                            ),
                          ),
                        ),
                        Container(
                            width: 230,
                            height: 50,
                            padding: EdgeInsets.only(left: 25),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 155,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Activity"),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.ac_unit),
                                  onPressed: () {
                                    print("test");
                                  },
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    color: Color(0xffDEF4ED),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    height: 60,
                    minWidth: double.infinity,
                    child: Text(
                      "Add activity",
                      style: TextStyle(
                          color: Color(0xff3FD4A2),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Text("Tab 2"),
            ),
            Container(
              child: Text("Tab 3"),
            ),
            Container(
              child: Text("Tab 4"),
            ),
          ],
        ),
      ),
    );
  }
}
