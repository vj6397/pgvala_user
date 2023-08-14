import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:pgvala_user/Api/requestUtil.dart';
import 'package:http/http.dart' as http;


class landlordDetails extends StatefulWidget {
  landlordDetails({required this.accid});
  String accid;

  @override
  State<landlordDetails> createState() => _landlordDetailsState();
}

class _landlordDetailsState extends State<landlordDetails> {
  List<dynamic> jsonData=[];
  String owner_name='';
  String contact1='';
  String contact2='';
  String address='';
  RequestUtil util=new RequestUtil();
  Future<void> _getData() async{
    http.Response response = await util.get_owner(widget.accid);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      jsonData= jsonDecode(response.body);
      print(jsonData[0]["contact1"]);
      setState(() {
        owner_name=jsonData[0]["owner_name"];
        contact1=jsonData[0]["contact1"];
        contact2=jsonData[0]["contact2"];
        address=jsonData[0]["address"];
      });
    }
    else print(response.body);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch direction');
    }
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:25.0),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    height: MediaQuery.of(context).size.height*0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: Color.fromARGB(255, 255, 48, 68))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15,top: 15,left: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 45,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: owner_name,
                                      prefixIcon: Icon(Icons.person,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 45,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: contact1,
                                      prefixIcon: Icon(Icons.phone,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 45,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: contact2,
                                      prefixIcon: Icon(Icons.phone,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white60,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 45,
                                  child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      filled: false,
                                      hintText: address,
                                      prefixIcon: Icon(Icons.add_road,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              InkWell(
                                onTap: (){
                                  print(jsonData[0]["latitude"]);
                                  print(jsonData[0]["longitude"]);
                                  _launchInBrowser(Uri.parse('https://www.google.com/maps/search/?api=1&query=${jsonData[0]["latitude"]},${jsonData[0]["longitude"]}'));
                                },
                                child: Container(
                                  height: 38,width: 114,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 48, 68),
                                    //border:Border.all(width: 1,color: Colors.green),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text('Get Directions',
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
