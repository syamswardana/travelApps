import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelApps/UI/add_day_page.dart';

class NewPlanPage extends StatefulWidget {
  @override
  _NewPlanPageState createState() => _NewPlanPageState();
}

class _NewPlanPageState extends State<NewPlanPage> {
  DateTime _rangeStartDate;
  DateTime _rangeEndDate;
  TextEditingController _planName = TextEditingController(text: "");
  String _ePlanName;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      _rangeStartDate = args.value.startDate;
      _rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
      print("one");
      final DateTime selectedDate = args.value;
    } else if (args.value is List<DateTime>) {
      final List<DateTime> selectedDates = args.value;
    } else {
      final List<PickerDateRange> selectedRanges = args.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          "New plan",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Stack(children: [
          ListView(
            children: [
              TextFormField(
                style: TextStyle(fontSize: 14),
                controller: _planName,
                onChanged: (value) {
                  (value != null || value != "") ? _ePlanName = null : null;
                },
                validator: (value) {
                  return (_ePlanName != null || _ePlanName != "")
                      ? _ePlanName
                      : null;
                },
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    labelText: "Plan name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25))),
              ),
              SizedBox(
                height: 20,
              ),
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
                selectionTextStyle: const TextStyle(color: Colors.white),
                selectionColor: Color(0xff3FD4A2),
                startRangeSelectionColor: Color(0xff3FD4A2),
                endRangeSelectionColor: Color(0xff3FD4A2),
                rangeSelectionColor: Colors.green[50],
                rangeTextStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              minWidth: double.infinity,
              onPressed: () {
                if (_rangeStartDate != null && _planName.text != "") {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddDayPage(
                      startDate: _rangeStartDate,
                      endDate: _rangeEndDate ?? _rangeStartDate,
                      planName: _planName.text,
                    );
                  }));
                } else {
                  _ePlanName = "Insert plane name";
                  setState(() {});
                }
              },
              color: Color(0xff3FD4A2),
              child: Text(
                "Continue",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
