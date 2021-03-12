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
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle subTab = new TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );

    int listday = 4;
    return DefaultTabController(
      length: listday,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
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
            tabs: List<Widget>.generate(listday, (index) {
              String day = (index + 1).toString();
              return Tab(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    "Maret $day",
                    style: subTab,
                  ),
                ),
                icon: Text(
                  "Day $day",
                  style: textTab,
                ),
              );
            }),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FlatButton(
          minWidth: MediaQuery.of(context).size.width - 40,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Next step",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
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
                            width: 110,
                            padding: EdgeInsets.only(right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)),
                            child: TextFormField(
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.left,
                              textAlignVertical: TextAlignVertical.center,
                              onSaved: (String val) {
                                _setTime = val;
                              },
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.access_time_outlined, size: 20),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 170,
                            height: 40,
                            padding: EdgeInsets.only(left: 25),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(25)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.center,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Activity",
                                        hintStyle: TextStyle(fontSize: 14)),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.ac_unit,
                                    size: 20,
                                  ),
                                  onPressed: () {},
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
                    minWidth: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Add activity",
                        style: TextStyle(
                            color: Color(0xff3FD4A2),
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
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
