import 'package:care_grantor/Medication_Reminder/addrem.dart';
import 'package:care_grantor/Medication_Reminder/medicationremainder.dart';
import 'package:care_grantor/Sos/sos.dart';
import 'package:care_grantor/Vitals_Monitering/vitals.dart';
import 'package:care_grantor/home.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

import 'Chat_Bot/AiAssistant.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int selectedIndex = 0;
  static  final List<Widget> _widgetOptions = <Widget>[
    const Home(),
    const MedicationRemainder(),
    const Sos(),
    // Vitals(date: '', rate: 0,) 
   const AIAssistant()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text('Flutter BottomNavigationBar Example'),
      //     backgroundColor: Colors.green),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 50,
        width: double.infinity,
        
        decoration:
         BoxDecoration(
          color: Colors.red,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 1),
            ),
          ]
          ),
        child: BottomNavigationBar(
          // backgroundColor: Colors.red,
          // selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          selectedItemColor: Colors.black,
          showUnselectedLabels:false,
          elevation: 0,
          items:  const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,),
              label: ('Home'),
              // backgroundColor: Colors.black
            
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.medical_information,),
              label: ('MedRem'),
              // backgroundColor: Colors.black
      
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sos_rounded),
              label: ('Sos'),
              // backgroundColor: Colors.black
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help),
              label: ('Ai'),
              // backgroundColor: Colors.black
            ),
          ],  
          currentIndex: selectedIndex,
          iconSize:20,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
