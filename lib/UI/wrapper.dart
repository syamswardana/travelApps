import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/UI/navigation.dart';
import 'package:travelApps/UI/started_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return (user != null) ? Navigation() : StartedPage();
  }
}
