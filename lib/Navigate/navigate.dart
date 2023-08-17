import 'package:flutter/material.dart';
import 'package:pgvala_user/QR/qr.dart';
import 'package:pgvala_user/user/bookingPage.dart';
import 'package:pgvala_user/user/homeScreen.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({required this.currIndx,required this.city});
  int currIndx;
  String city;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}


class _NavigationScreenState extends State<NavigationScreen> {
  late List<Widget> screens; // Declare the list as 'late'

  @override
  void initState() {
    super.initState();
    screens = [
      homeScreen(city: widget.city,currIndx: 0,),
      qr(),
      bookingPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currIndx,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        currentIndex: widget.currIndx,
        onTap: (index) {
          setState(() {
            widget.currIndx = index;
          });
        },
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Open QR'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined),label: 'Bookings'),
        ],
      ),
    );
  }
}