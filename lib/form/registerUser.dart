import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgvala_user/Api/requestUtil.dart';
import 'package:pgvala_user/login/otp_verification.dart';
import 'package:pgvala_user/selectCity.dart';
import 'package:http/http.dart'as http;

import '../location_list.dart';


//register_accomodation.
class registerUser extends StatefulWidget {
  const registerUser({super.key});

  @override
  State<registerUser> createState() => _registerUserState();
}

class _registerUserState extends State<registerUser> {
  String name = "";
  String contact= "";
  String city="";
  String state="";
  String address = "";
  String dob = "";
  String working_place="";
  List radioOptionProfession=['Student','Working professional','self employed','freelancer'];
  String? selectedOptionProfessionStatus;

  RequestUtil util=new RequestUtil();

  var course_list=course;
  String dropdownvalue=course.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left:MediaQuery.of(context).size.width/2-80,top: 30),
                child: Text(
                  'Register Yourself',
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16,right: 15),
                      child: Text(
                        'Name',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          name = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter your Name'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Contact details',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          contact = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter your Conatct'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 16,bottom: 4),
                      child: Text(
                        'State',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          state = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter your state'),
                      ),
                    ),
                    SizedBox(height:20,),
                    Container(
                      margin: EdgeInsets.only(left: 16,bottom: 4),
                      child: Text(
                        'City',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          city = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter your City'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Address',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          address = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter Address'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 16,bottom: 4),
                      child: Text(
                        'Username',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        //no input in the username
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter your userName',
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'DOB',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          dob = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'dd-mm-yyyy'),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text('Profession type:-',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            for(String option in radioOptionProfession)
                              RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOptionProfessionStatus,
                                onChanged: (val){
                                  setState(() {
                                    selectedOptionProfessionStatus=val;
                                  });
                                },
                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Working place details',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        onChanged: (val) {
                          working_place = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter Working place'),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Course Type',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownvalue,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            menuMaxHeight: 200,
                            items: course_list.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Padding( // Add padding to the DropdownMenuItem to match the style
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                  child: Text(
                                    e.toString(),
                                    style: GoogleFonts.notoSans(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: ()async{
                              http.Response res=await util.register_user(name,contact,city,state,address,'username',dob,radioOptionProfession.toString(),working_place,dropdownvalue);
                              if(res.statusCode==200){
                                print(res.body);
                                http.Response res1=await util.resendOtp(contact);
                                if(res1.statusCode==200&&contact!=''){
                                  print(res1.body);
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerify(number: contact)));
                                }
                                else {
                                  print(res1.body);
                                  Fluttertoast.showToast(
                                    msg: 'Enter valid details',
                                    toastLength: Toast.LENGTH_SHORT, // Duration of the toast
                                    gravity: ToastGravity.BOTTOM,    // Position on the screen
                                    backgroundColor: Colors.black54, // Background color of the toast
                                    textColor: Colors.white,         // Text color of the toast message
                                    fontSize: 16.0,                 // Font size of the toast message
                                  );
                                }
                              }
                              else{
                                print(res.body);
                                Fluttertoast.showToast(
                                  msg: 'Enter valid details',
                                  toastLength: Toast.LENGTH_SHORT, // Duration of the toast
                                  gravity: ToastGravity.BOTTOM,    // Position on the screen
                                  backgroundColor: Colors.black54, // Background color of the toast
                                  textColor: Colors.white,         // Text color of the toast message
                                  fontSize: 16.0,                 // Font size of the toast message
                                );
                              }
                            },
                            child: Container(
                              height: 38,width: 114,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                //border:Border.all(width: 1,color: Colors.green),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


