import 'package:chaya_team/pages/login.dart';
import 'package:chaya_team/pages/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      // home: Screen1(),
      // home: LoginPage(),
      home: ScreenSplash(),
      // home: const Homescreen(),
    );
  }
}

// import 'package:flutter_application_1/login.dart';
