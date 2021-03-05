import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class NewPlanPage extends StatefulWidget {
  @override
  _NewPlanPageState createState() => _NewPlanPageState();
}

class _NewPlanPageState extends State<NewPlanPage> {
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
      final DateTime rangeStartDate = args.value.startDate;
      final DateTime rangeEndDate = args.value.endDate;
    } else if (args.value is DateTime) {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/bali.jpg"), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(7)),
              child: RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    children: [
                      TextSpan(text: "Destination\n"),
                      TextSpan(
                          text: "Bali, Indonesia",
                          style: TextStyle(
                              fontFamily: "DancingScript",
                              fontWeight: FontWeight.w800,
                              fontSize: 26))
                    ]),
              ),
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
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  height: 60,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Next step",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff3FD4A2),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
