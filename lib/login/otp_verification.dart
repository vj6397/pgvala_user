import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import 'package:http/http.dart'as http;
import 'package:pgvala_user/selectCity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Api/requestUtil.dart';
import '../location_list.dart';


class OtpVerify extends StatefulWidget {
  OtpVerify({required this.number});

  String number;

  @override
  State<OtpVerify> createState() => _OtpVerifyState();
}

class _OtpVerifyState extends State<OtpVerify> {
  int _remainingTime = 30; //initial time in seconds
  late Timer _timer;
  String _otp="";
  RequestUtil util=new RequestUtil();

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime-=1;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              margin: EdgeInsets.only(right: 20),
                              width: 35,
                              height: 35,
                              child: Image(
                                  image: AssetImage('assets/backArrow.jpg'))),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Text(
                            'We have sent a verification code to',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 9),
                    child: Text(
                      '+91-'+widget.number,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width - 70,
                    child: OTPTextField(
                      length: 5, // Length of OTP (default is 6)
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 30,
                      style: TextStyle(fontSize: 17),
                      textFieldAlignment: MainAxisAlignment.spaceEvenly,
                      fieldStyle: FieldStyle.underline,
                      onChanged: (otp) {
                        // Handle OTP input changes
                      },
                      onCompleted: (otp){
                        // Handle OTP verification
                        _otp=otp;
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width-50,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: InkWell(
                      onTap:()async{
                        http.Response res= await util.login(widget.number.toString(), _otp);
                        if(res.statusCode==200){
                          print(res.body);
                          var shr=await SharedPreferences.getInstance();
                          shr.setBool(keyVal, true);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>selectCity()));
                        }

                        else{
                          print('hello');
                          Fluttertoast.showToast(
                              msg: "Invalid OTP",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      },
                      child: Center(
                        child: Text('Login',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      _remainingTime.toString()+' seconds',
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.only(right: 30,left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Didn\'t receive the code?',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ),),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: ()async{
                            http.Response res=await util.resendOtp(num);
                            if(res.statusCode==200) {
                              print(res.body);
                              Fluttertoast.showToast(
                                  msg: "new OTP is sent to your number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child: Text('Resend Code',
                            style: GoogleFonts.openSans(
                              color: Color(0xffC4C4C4),
                              fontSize: 13,
                            ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}