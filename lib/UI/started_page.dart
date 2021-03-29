import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:travelApps/UI/form_email.dart';
import 'package:travelApps/UI/navigation.dart';

class StartedPage extends StatelessWidget {
  final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0, //effect timbul bawah
          backgroundColor: Colors.white,
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Get Started",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      button(
                          icon: Icon(
                            Icons.mail,
                            size: 24,
                          ),
                          text: "Create account",
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormEmail();
                            }));
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          icon: Icon(
                            Icons.mail,
                            size: 24,
                          ),
                          text: "Login with email",
                          onPress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormEmail(
                                isLogin: true,
                              );
                            }));
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Or continue with",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          icon: Image.asset(
                            "assets/gmail.png",
                            height: 20,
                          ),
                          text: "Continue with gmail",
                          onPress: () {
                            Future<UserCredential> user =
                                AuthServices.signInWithGoogle();
                            user.then((user) {
                              if (user != null) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Navigation();
                                }));
                              }
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      button(
                          background: Color.fromARGB(255, 60, 89, 152),
                          text: "Continue with facebook",
                          icon: Image.asset(
                            "assets/facebook.png",
                            height: 20,
                          ),
                          textColor: Colors.white,
                          onPress: () {
                            print("test");
                            final SnackBar snackBar =
                                SnackBar(content: Text("Fitur belum tersedia"));
                            globalKey.currentState.showSnackBar(snackBar);
                          }),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  Widget button(
      {Color background,
      Color textColor,
      Widget icon,
      String text,
      Function onPress}) {
    return FlatButton(
      color: background,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(30)),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.fromLTRB(40, 15, 0, 15),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 25,
            ),
            Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: textColor, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
