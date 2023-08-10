import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgvala_user/utils/utils.dart';
import 'package:intl/intl.dart';


class scheduleVisit extends StatefulWidget {
  const scheduleVisit({super.key});

  @override
  State<scheduleVisit> createState() => _scheduleVisitState();
}

class _scheduleVisitState extends State<scheduleVisit> {
  var gender_list=gender;
  String dropdownvaluegender=gender.first;
  var duration_list=duration;
  String dropdownduration=duration.first;
  DateTime selectedDateTime = DateTime.now();
  Future<void> _selectDates(BuildContext context)async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = picked;
        print(selectedDateTime);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
    );

    if (picked != null) {
      setState(() {
        selectedDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          picked.hour,
          picked.minute,
        );
        print(selectedDateTime);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                          height: MediaQuery.of(context).size.height*0.5,
                          width: MediaQuery.of(context).size.width*0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color.fromARGB(255, 255, 48, 68)),
                              borderRadius: BorderRadius.circular(17),
                              //color: Color.fromARGB(255, 255, 48, 68),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 15,),
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          height: 45,
                                          child: TextField(
                                            onChanged: (String st){
                                              setState(() {
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              filled: false,
                                              prefixIcon: Icon(Icons.phone,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                              fillColor: Colors.white70,
                                              hintText: 'Mobile Number',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 15),
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          height: 45,
                                          child: TextField(
                                            onChanged: (String st){
                                              setState(() {
                                              });
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: false,
                                              prefixIcon: Icon(Icons.email,size:20,color: Color.fromARGB(255, 255, 48, 68)),
                                              fillColor: Colors.white70,
                                              hintText: 'Email ID',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: dropdownvaluegender,
                                              icon: Icon(Icons.keyboard_arrow_down),
                                              isExpanded: true,
                                              menuMaxHeight: 200,
                                              items: gender_list.map<DropdownMenuItem<String>>((e) {
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
                                                  dropdownvaluegender = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding:  EdgeInsets.only(right:100),
                                        child: Text('What is your duratiion of stay?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          height: 45,
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: dropdownduration,
                                              icon: Icon(Icons.keyboard_arrow_down),
                                              isExpanded: true,
                                              menuMaxHeight: 200,
                                              items: duration_list.map<DropdownMenuItem<String>>((e) {
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
                                                  dropdownduration = newValue!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 9.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text('What is your preferred date and time slot?',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 30.0),
                                      //   child: Text(
                                      //     DateFormat('MMMM d, y - h:mm a').format(selectedDateTime),
                                      //     style: TextStyle(fontSize: 21, fontWeight: FontWeight.normal),
                                      //   ),
                                      // ),
                                      SizedBox(height:8,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 30),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            OutlinedButton(
                                              onPressed: (){
                                                _selectDates(context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Select dates',style: TextStyle(color: Colors.black),),
                                            ),
                                            // SizedBox(height: 7,),
                                            OutlinedButton(
                                              onPressed: (){
                                                _selectTime(context);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                              ),
                                              child: Text('Select Time',style: TextStyle(color: Colors.black),),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(height: 25,),
                    Container(
                      width: 120,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(color: Color.fromARGB(255, 255, 48, 68),width: 1),
                          borderRadius: BorderRadius.circular(13),
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Center(child: Text('Schedule Now')),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        )
      ),
    );
  }
}
