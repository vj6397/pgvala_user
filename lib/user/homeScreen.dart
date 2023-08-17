import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pgvala_user/user/hoomscreenTile.dart';

import '../Api/requestUtil.dart';


class homeScreen extends StatefulWidget {
  homeScreen({required this.city,required this.currIndx});
  String city;
  int currIndx=0;

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  RequestUtil util  = new RequestUtil();
  List<dynamic> jsonData=[];
  List<Widget> userRoom=[];
  String jsonString="{\"acc06Rm01_img1\": \"31430e56-06ff-407a-b7af-ca3d8bad2045.jpg\", \"acc06Rm01_img2\": \"aff0e0f3-13a3-47ca-8f07-fcd62a5114eb.jpg\", \"acc06Rm01_img3\": \"496265fe-a5b9-4396-972d-fcc2126a80bf.jpg\"}";

  List<String> localities=[];
  List<String> sharing=['Single Sharing','Double Sharing','Three Sharing','1bhk','2bhk','3bhk'];
  List<String> tenant_type=['Girls','Boys','Family'];
  String dropdownvalueRoomSharing ='';
  String dropdownvaluelocality ='';
  String dropdownvaluetenant ='';

  void _openFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(16),
              height: 350, // Adjust the height as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/2-80),
                    child: Text('Apply Filters',style: TextStyle(color: Colors.pinkAccent,
                    fontSize: 18),),
                  ),
                  Container(
                  margin: EdgeInsets.only(left: 15,top: 10),
                  child: Text(
                    'Sharing Type',
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width-150,
                        margin: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownvalueRoomSharing,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            menuMaxHeight: 200,
                            items: sharing.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Padding(
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
                                dropdownvalueRoomSharing = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () async {
                          await getDataFilter_sharing(dropdownvalueRoomSharing);
                          // Call the functions that need to be refreshed
                          await _getData();
                          await getlocalities();
                          Navigator.pop(context);
                        },
                        child: Text('filter',style:GoogleFonts.poppins(
                      fontSize: 15,color: Colors.redAccent
                    ),))
                  ],
                ),
                SizedBox(height: 5),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    'Tenant Type',
                    style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width-150,
                        margin: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownvaluetenant,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            menuMaxHeight: 200,
                            items: tenant_type.map<DropdownMenuItem<String>>((e) {
                              return DropdownMenuItem<String>(
                                value: e,
                                child: Padding(
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
                                dropdownvaluetenant = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          getDataFilter_tenant(dropdownvaluetenant);
                          // Call the functions that need to be refreshed
                          // await _getData();
                          getlocalities();
                          Navigator.pop(context);
                        },
                        child: Text('filter',style:GoogleFonts.poppins(
                        fontSize: 15,color: Colors.redAccent
                    ),))
                  ],
                ),
                // Container(
                //   margin: EdgeInsets.only(left: 15,top: 10),
                //   child: Text(
                //     'Localities',
                //     style: GoogleFonts.notoSans(
                //         fontWeight: FontWeight.w600, fontSize: 12),
                //   ),
                // ),
                // SizedBox(height: 5),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(5.0),
                //       child: Container(
                //         width: MediaQuery.of(context).size.width-150,
                //         margin: EdgeInsets.only(left: 5, right: 10),
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.grey),
                //           borderRadius: BorderRadius.circular(12),
                //         ),
                //         child: DropdownButtonHideUnderline(
                //           child: DropdownButton<String>(
                //             value: dropdownvaluelocality,
                //             icon: Icon(Icons.keyboard_arrow_down),
                //             isExpanded: true,
                //             menuMaxHeight: 200,
                //             items: localities.map<DropdownMenuItem<String>>((e) {
                //               return DropdownMenuItem<String>(
                //                 value: e,
                //                 child: Padding(
                //                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                //                   child: Text(
                //                     e.toString(),
                //                     style: GoogleFonts.notoSans(
                //                       fontSize: 15,
                //                       fontWeight: FontWeight.w400,
                //                       color: Colors.black,
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             }).toList(),
                //             onChanged: (String? newValue) {
                //               setState(() {
                //                 dropdownvaluelocality = newValue!;
                //               });
                //             },
                //           ),
                //         ),
                //       ),
                //     ),
                //     TextButton(
                //         onPressed: () async {
                //           await getDataFilter_localities(dropdownvaluelocality);
                //           // localities.clear();
                //           // Call the functions that need to be refreshed
                //           // await _getData();
                //           await getlocalities();
                //           Navigator.pop(context);
                //         },
                //         child: Text('filter',style:GoogleFonts.poppins(
                //         fontSize: 15,color: Colors.redAccent
                //     ),))
                //   ],
                // ),
                ],
              ),
            );
          },
        );
      },
    );
  }



  Future<void> getlocalities() async{
    http.Response response = await util.localityList(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      jsonData= jsonDecode(response.body);
      var i=0;
      while(i<jsonData.length){
        setState(() {
          localities.add(jsonData[i]["locality"]);
        });
        i++;
      }
      print(jsonData);
      print(jsonData[0]["locality"]);
      if (localities.isNotEmpty) {
        dropdownvaluelocality = localities.first;
      }
    }
    else print("error");
  }

  Future<void> _getData() async{
    http.Response response = await util.accomodation_List(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
      setState(() {
        jsonData= jsonDecode(response.body);
        while(i<jsonData.length){
          userRoom.add(homescreenTile(Apartmentname: jsonData[i]["apartment_name"], locality: jsonData[i]["locality"], rentPrice:jsonData[i]["rent_price"].toString(), rate: jsonData[i]["rate"], washrrom_status: jsonData[i]["washroom_status"], category: jsonData[i]["category"], tenant: jsonData[i]["tenant"], accomodation_type: jsonData[i]["accomotation_type"], imgList: jsonData[i]["images"]??jsonString,perks: jsonData[i]["perks"]??"No perks",accid: jsonData[i]["accid"],roomId: jsonData[i]["roomid"],));
          i++;
        }
        print(jsonData[0]["rent_price"]);
        print(jsonData[0]["apartment_name"]);
        print(jsonData[0]["locality"]);
      });
    }
    else print("error");
  }

  Future<void> getDataFilter_sharing(sharing_type) async{
    http.Response response = await util.accomodation_List(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
      setState(() {
        userRoom.clear();
        jsonData= jsonDecode(response.body);
        while(i<jsonData.length&&jsonData[i]["accomotation_type"].toString().toLowerCase()==sharing_type.toString().toLowerCase()){
          userRoom.add(homescreenTile(Apartmentname: jsonData[i]["apartment_name"], locality: jsonData[i]["locality"], rentPrice:jsonData[i]["rent_price"].toString(), rate: jsonData[i]["rate"], washrrom_status: jsonData[i]["washroom_status"], category: jsonData[i]["category"], tenant: jsonData[i]["tenant"], accomodation_type: jsonData[i]["accomotation_type"], imgList: jsonData[i]["images"]??jsonString,perks: jsonData[i]["perks"]??"No perks",accid: jsonData[i]["accid"],roomId: jsonData[i]["roomid"]));
          i++;
        }
      });
    }
    else print("error");
  }

  Future<void> getDataFilter_tenant(tenant_type) async{
    http.Response response = await util.accomodation_List(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
      setState(() {
        userRoom.clear();
        jsonData= jsonDecode(response.body);
        while(i<jsonData.length&&jsonData[i]["tenant"].toString().toLowerCase()==tenant_type.toString().toLowerCase()){
          userRoom.add(homescreenTile(Apartmentname: jsonData[i]["apartment_name"], locality: jsonData[i]["locality"], rentPrice:jsonData[i]["rent_price"].toString(), rate: jsonData[i]["rate"], washrrom_status: jsonData[i]["washroom_status"], category: jsonData[i]["category"], tenant: jsonData[i]["tenant"], accomodation_type: jsonData[i]["accomotation_type"], imgList: jsonData[i]["images"]??jsonString,perks: jsonData[i]["perks"]??"No perks",accid: jsonData[i]["accid"],roomId: jsonData[i]["roomid"]));
          i++;
        }
      });
    }
    else print("error");
  }

  Future<void> getDataFilter_localities(locality_type) async{
    http.Response response = await util.accomodation_List(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      var i=0;
      setState(() {
        userRoom.clear();
        jsonData= jsonDecode(response.body);
        while(i<jsonData.length&&jsonData[i]["locality"].toString().toLowerCase()==dropdownvaluelocality.toString().toLowerCase()){
          userRoom.add(homescreenTile(Apartmentname: jsonData[i]["apartment_name"], locality: jsonData[i]["locality"], rentPrice:jsonData[i]["rent_price"].toString(), rate: jsonData[i]["rate"], washrrom_status: jsonData[i]["washroom_status"], category: jsonData[i]["category"], tenant: jsonData[i]["tenant"], accomodation_type: jsonData[i]["accomotation_type"], imgList: jsonData[i]["images"]??jsonString,perks: jsonData[i]["perks"]??"No perks",accid: jsonData[i]["accid"],roomId: jsonData[i]["roomid"]));
          i++;
        }
      });
    }
    else print("error");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
    getlocalities();

    if (sharing.isNotEmpty) {
      dropdownvalueRoomSharing = sharing.first;
    }
    if (tenant_type.isNotEmpty) {
      dropdownvaluetenant = tenant_type.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width-100),
                child: TextButton(onPressed:(){
                  _openFilterBottomSheet(context);
                },
                    child: Text('Filters',style: TextStyle(color: Colors.redAccent),)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: userRoom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}