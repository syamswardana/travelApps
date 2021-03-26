import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String msg;
  ErrorPage({this.msg});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          msg,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
