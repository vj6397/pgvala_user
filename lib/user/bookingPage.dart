import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgvala_user/Api/requestUtil.dart';
import 'package:http/http.dart' as http;
import 'package:pgvala_user/user/bookingTile.dart';

class bookingPage extends StatefulWidget {
  const bookingPage({super.key});

  @override
  State<bookingPage> createState() => _bookingPageState();
}

class _bookingPageState extends State<bookingPage> {
  RequestUtil util = new RequestUtil();
  List<dynamic> jsonData=[];
  List<Widget> bookings=[];

  Future<void> _getData() async{
    http.Response response = await util.visitTime();
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
      setState(() {
        jsonData= jsonDecode(response.body);
        while(i<jsonData.length){
          bookings.add(bookingTile(date: jsonData[i]["date"], visiting_time: jsonData[i]["visting_time"], apartment_name: jsonData[i]["apartment_name"], owner_name: jsonData[i]["owner_name"], contact: jsonData[i]["contact1"], address: jsonData[i]["address"],entry_id: jsonData[i]["entery_id"].toString(),status: jsonData[i]["status"],));
          i++;
        }
        print(jsonData[0]["date"]);
        print(jsonData[0]["status"]);
        print(jsonData[0]["apartment_name"]);
        print(jsonData[0]["entery_id"]);
      });
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20,left: 15,top: 10),
                child: Text('My Bookings',
                  style:  GoogleFonts.poppins (
                    fontSize:  15,
                    fontWeight:  FontWeight.w600,
                    color:  Color(0xff201a25),
                  ),
                ),
              ),
              Column(
                children: bookings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
