import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class homescreenTile extends StatefulWidget {
  homescreenTile({required this.Apartmentname,required this.locality,required this.rentPrice,required this.rate,required this.washrrom_status,required this.category,required this.tenant,required this.accomodation_type,required this.imgList});
  String Apartmentname;
  String locality;
  String rentPrice;
  String rate;
  String washrrom_status;
  String category;
  String tenant;
  String accomodation_type;
  String imgList;


  @override
  State<homescreenTile> createState() => _homescreenTileState();
}

class _homescreenTileState extends State<homescreenTile> {
  int currentindex=0;

  final CarouselController carouselController = CarouselController();

  final List imageAssets = [
    // {"id":1,"image_path":'assets/bed1.png'},
    // {"id":2,"image_path":'assets/bed2.png'},
  ];
  void get_images(){
    String jsonString =widget.imgList;
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    List<String> filenames = jsonMap.values.map<String>((value) => value.toString()).toList();
    print(filenames);
    for (int i = 0; i < filenames.length; i++) {
      String imagePath = filenames[i];
      Map<String, dynamic> imageData = {"id": i, "image_path": imagePath};
      imageAssets.add(imageData);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_images();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10,right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Stack(
                children: [
                  InkWell(
                    onTap: (){
                      print(currentindex);
                    },
                    child: CarouselSlider(
                      items: imageAssets.map(
                              (item) => Image.network(
                                'https://pgvala.s3.amazonaws.com/${item["image_path"]}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                          )
                      )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: false,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason){
                            setState(() {
                              currentindex = index;
                            });
                          }
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageAssets.asMap().entries.map((entry){
                        // print(entry);
                        // print(entry.key);
                        return GestureDetector(
                          onTap: () => carouselController.animateToPage(entry.key),
                          child: Container(
                            width: currentindex == entry.key?17:7,
                            height: 7,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 3.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: currentindex == entry.key
                                  ?Colors.red
                                  :Colors.teal,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 16,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('${widget.Apartmentname}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Icon(Icons.check_circle,color: Colors.green,),
                      SizedBox(width: 100,),
                      TextButton(
                        onPressed: (){
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context){
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height-80,
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Aminities Listed'),
                                      SizedBox(height: 20,),
                                      ElevatedButton(onPressed: (){Navigator.pop(context);},
                                          child: Text('Close'))
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        child: Text('See aminities'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${widget.locality}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // SizedBox(height: 15,),
                        Container(
                          width: 140,
                          height: 25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // color: Color.fromARGB(255, 255, 48, 68),
                          ),
                          child: Center(
                            child: Text(
                              '${double.parse(widget.rentPrice).toInt()}/${widget.rate}',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        height: 25,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                          // color: Color.fromARGB(255, 255, 48, 68),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.washrrom_status}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        width: 120,
                        height: 25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)
                          // color: Color.fromARGB(255, 255, 48, 68),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.category}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.person,size: 20,color: Color.fromARGB(255, 255, 48, 68)),
                      // SizedBox(width: 5,),
                      Text('${widget.tenant}'),
                      // SizedBox(width: 5,),
                      Text('|'),
                      // SizedBox(width: 5,),
                      Icon(Icons.bed,size: 20,color: Color.fromARGB(255, 255, 48, 68)),
                      // SizedBox(width: 5,),
                      Text('${widget.accomodation_type}'),
                      InkWell(
                        onTap: (){},
                        child: Container(
                            width: 125,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blue),
                              // color: Color.fromARGB(255, 255, 48, 68),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Reserve Now',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                        ),
                      )
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
