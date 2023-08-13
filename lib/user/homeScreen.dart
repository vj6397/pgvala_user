import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pgvala_user/user/hoomscreenTile.dart';

import '../Api/requestUtil.dart';


class homeScreen extends StatefulWidget {
  homeScreen({required this.city});
  String city;

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  RequestUtil util  = new RequestUtil();
  List<dynamic> jsonData=[];
  List<Widget> userRoom=[];

  Future<void> _getData() async{
    http.Response response = await util.accomodation_List(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
     setState(() {
       jsonData= jsonDecode(response.body);
       while(i<jsonData.length){
         userRoom.add(homescreenTile(Apartmentname: jsonData[i]["apartment_name"], locality: jsonData[i]["locality"], rentPrice:jsonData[i]["rent_price"].toString(), rate: jsonData[i]["rate"], washrrom_status: jsonData[i]["washroom_status"], category: jsonData[i]["category"], tenant: jsonData[i]["tenant"], accomodation_type: jsonData[i]["accomotation_type"], imgList: jsonData[i]["images"],perks: jsonData[i]["perks"]??"No perks"));
         i++;
       }
       print(jsonData[0]["rent_price"]);
       print(jsonData[0]["apartment_name"]);
       print(jsonData[0]["locality"]);
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: userRoom,
          ),
        ),
      ),
    );
  }
}
