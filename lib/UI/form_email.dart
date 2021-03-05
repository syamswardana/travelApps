import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:travelApps/UI/wrapper.dart';

class FormEmail extends StatefulWidget {
  final bool isLogin;
  FormEmail({Key key, this.isLogin = false});
  @override
  _FormEmailState createState() => _FormEmailState(isLogin: isLogin);
}

class _FormEmailState extends State<FormEmail> {
  final bool isLogin;
  final TextEditingController _email = TextEditingController(text: "");
  final TextEditingController _password = TextEditingController(text: "");
  final TextEditingController _rePassword = TextEditingController(text: "");
  String _errorPassword;
  String _errorEmail;

  _FormEmailState({this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Text(
              (!isLogin) ? "Create an account" : "Login Account",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 15),
              child: Text(
                "E-mail address",
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextFormField(
                style: TextStyle(fontSize: 14, color: Colors.black),
                controller: _email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => !EmailValidator.validate(value)
                    ? "Masukan email yang benar"
                    : _errorEmail != null
                        ? _errorEmail
                        : null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.grey,
                      size: 20,
                    ),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 60, minHeight: 20),
                    hintText: "Input your email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)))),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 15),
              child: Text(
                "Password",
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextFormField(
                style: TextStyle(fontSize: 14, color: Colors.black),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  print(_errorPassword);
                  return (_errorPassword != null) ? _errorPassword : null;
                },
                obscureText: true,
                controller: _password,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 5),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(30)),
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: Colors.grey,
                      size: 20,
                    ),
                    prefixIconConstraints:
                        BoxConstraints(minWidth: 60, minHeight: 20),
                    hintText: (!isLogin) ? "Create a password" : "Password",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(30)))),
            (!isLogin)
                ? Container(
                    margin: EdgeInsets.only(top: 20, bottom: 15),
                    child: Text(
                      "Repeat Password",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : Container(),
            (!isLogin)
                ? TextFormField(
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    obscureText: true,
                    controller: _rePassword,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return (value == _password.text)
                          ? null
                          : "Password tidak sama";
                    },
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.grey,
                          size: 20,
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 60, minHeight: 15),
                        hintText: "Repeat password",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30))),
                  )
                : Container(),
            (!isLogin)
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Checkbox(
                          onChanged: (check) {},
                          value: true,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: Color(0xff3FD4A2),
                        ),
                        Text(
                          "I have read the ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Terms of Sevice",
                          style: TextStyle(
                              color: Color(0xff3FD4A2),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: 20,
                  ),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                onPressed: () async {
                  if (!isLogin) {
                    if (_password.text == _rePassword.text) {
                      try {
                        await AuthServices.signUpEmail(
                            email: _email.text, password: _password.text);
                        Navigator.pop(context);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          _errorPassword = "Password terlalu lemah";
                          print("Password sdh digunakan");
                        } else if (e.code == 'email-already-in-use') {
                          _errorEmail = "Email sudah digunakan";
                        }
                        setState(() {});
                      } catch (e) {
                        print(e);
                      }
                    }
                  } else {
                    try {
                      await AuthServices.signInEmail(
                          email: _email.text, password: _password.text);
                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        _errorEmail = "User tidak ditemukan";
                      } else if (e.code == 'wrong-password') {
                        _errorPassword = "Password tidak cocok";
                      }
                      setState(() {});
                    }
                  }
                },
                color: Color(0xff3FD4A2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
