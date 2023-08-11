import 'package:flutter/material.dart';


class landlordDetails extends StatefulWidget {
  const landlordDetails({super.key});

  @override
  State<landlordDetails> createState() => _landlordDetailsState();
}

class _landlordDetailsState extends State<landlordDetails> {
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
                                      hintText: 'Owner Name',
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
                                      hintText: 'Owner Contact',
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
                                      hintText: 'Apartment Name',
                                      prefixIcon: Icon(Icons.apartment,size:20,color: Color.fromARGB(255, 255, 48, 68)),
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
                                      hintText: 'Address',
                                      prefixIcon: Icon(Icons.add_road,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              InkWell(
                                onTap: (){
                                  //Navigator.push(context, MaterialPageRoute(builder: (context)=>selectCity()));
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
