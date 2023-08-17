import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pgvala_user/form/registerUser.dart';
import 'package:pgvala_user/selectCity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Navigate/navigate.dart';
import 'location_list.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(primarySwatch: Colors.green),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getLoggedInState() async {
    var shr=await SharedPreferences.getInstance();
    var userIsLoggedIn=shr.getBool(keyVal);
    Timer(
      Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => userIsLoggedIn != null
                ? userIsLoggedIn
                ? selectCity()
                : registerUser()
                : registerUser()),
      ),
    );
  }
  Future<void> get_token() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ktoken=prefs.getString('token2');
  }

  @override
  initState(){
    super.initState();
    getLoggedInState();
    get_token();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}