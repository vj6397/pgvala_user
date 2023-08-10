import 'package:flutter/material.dart';
import 'package:pgvala_user/form/registerUser.dart';
import 'package:pgvala_user/form/scheduleVisit.dart';
import 'package:pgvala_user/user/hoomscreenTile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: scheduleVisit(),
    );
  }
}

