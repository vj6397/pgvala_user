import 'package:flutter/material.dart';
import 'package:pgvala_user/user/bookingPage.dart';

import '../main.dart';



class circularProgressIndicator extends StatefulWidget {
  const circularProgressIndicator({super.key});

  @override
  State<circularProgressIndicator> createState() => _circularProgressIndicatorState();
}

class _circularProgressIndicatorState extends State<circularProgressIndicator> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
