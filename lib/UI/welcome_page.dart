import 'package:flutter/material.dart';
import 'package:travelApps/UI/started_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatelessWidget {
  _setIsFirst(bool isFirst) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirst", isFirst);
    print(prefs.getBool("isFirst"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/travel_illustration.png"),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Plan your trip easiest \nway possible.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center),
            SizedBox(
              height: 20,
            ),
            Text(
              "Find interesting destinations and \ncreate plans for trips in seconds.",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
                color: Color(0xff3FD4A2),
                onPressed: () {
                  _setIsFirst(false);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return StartedPage();
                  }));
                },
                shape: CircleBorder(),
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30,
                ))
          ],
        ),
      ),
    );
  }
}
