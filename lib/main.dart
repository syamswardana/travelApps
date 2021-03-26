import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:travelApps/Firebase/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelApps/UI/loading_page.dart';
import 'package:travelApps/UI/welcome_page.dart';
import 'package:travelApps/UI/wrapper.dart';
import 'package:travelApps/bloc/activitiescrud_bloc.dart';
import 'package:travelApps/bloc/activitiesonline_bloc.dart';
import 'package:travelApps/bloc/plans_bloc.dart';
// import 'package:travelApps/Firebase/auth_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirst = true;
  bool _isLoaded = false;
  bool _initialized = false;
  bool _error = false;

  Future<void> _getIsFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isFirst = prefs.getBool("isFirst") ?? true;
    _isLoaded = true;
    setState(() {});
  }

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        print(e.toString);
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    _getIsFirst();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: LoadingPage(),
    //   ),
    // );
    if (_error) {
      return MaterialApp(
        home: LoadingPage(),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return MaterialApp(
        home: LoadingPage(),
      );
    }
    return StreamProvider.value(
        value: AuthServices.firebaseUserStream,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ActivitiesCrudBloc>(
              create: (context) => ActivitiesCrudBloc(),
            ),
            BlocProvider<ActivitiesOnlineBloc>(
              create: (context) => ActivitiesOnlineBloc(),
            ),
            BlocProvider<PlansBloc>(
              create: (context) => PlansBloc(),
            )
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: (!_isLoaded)
                ? Center(child: CircularProgressIndicator())
                : (_isFirst)
                    ? WelcomePage()
                    : Wrapper(),
          ),
        ));
  }
}
