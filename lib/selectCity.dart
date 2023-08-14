import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pgvala_user/Navigate/navigate.dart';
import 'package:pgvala_user/user/homeScreen.dart';

import 'Api/requestUtil.dart';

class selectCity extends StatefulWidget {
  const selectCity({super.key});

  @override
  State<selectCity> createState() => _selectCityState();
}

class _selectCityState extends State<selectCity> {
  List<String> city_list=[];
  String? dropdownvalue;
  RequestUtil util  = new RequestUtil();
  List<dynamic> jsonData=[];

  Future<void> _getData() async{
    http.Response response = await util.cityList();
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      jsonData= jsonDecode(response.body);
      var i=0;
      while(i<jsonData.length){
        setState(() {
          city_list.add(jsonData[i]["city_name"]);
        });
        i++;
      }
      print(jsonData);
      print(jsonData[0]["city_name"]);
      // print(jsonData["apartment_name"]);
    }
    else print("error");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(left: 1),
                      child: Text(
                        'City',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    margin: EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        menuMaxHeight: 150,
                        items: city_list.map<DropdownMenuItem<String>>((e) {
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
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>NavigationScreen(currIndx: 0, city:dropdownvalue!)));
                    },
                    child: Container(
                      height: 38,
                      width: 114,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}
