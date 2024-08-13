import 'package:care_grantor/Medication_Reminder/monthmedrem.dart';
import 'package:care_grantor/Medication_Reminder/todaymedrem.dart';
import 'package:care_grantor/Medication_Reminder/weekmedrem.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class TabNav extends StatefulWidget {
  const TabNav({Key? key}) : super(key: key);
  // final bool _isHovering=false;

  @override
  State<TabNav> createState() => _TabNavState();
}

class _TabNavState extends State<TabNav> with TickerProviderStateMixin {
  late bool _isHovering = true;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    return Column(
      children: [
        // SizedBox(height: 50,),
        Container(
          height: 70,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 29, 28, 28),
                  // Color(0x596164FF),
                  Color.fromARGB(255, 33, 33, 33),
                // Colors.blueGrey,
              ],
            ),
          ),
          child: TabBar(
              labelColor: Colors.greenAccent,
              unselectedLabelColor: Colors.grey,
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'Today',
                  // icon: Icon(Icons.today),
                ),
                Tab(
                  text: 'Week',
                  // icon: Icon(Icons.weekend),
                ),
                Tab(
                  text: 'Month',
                  // icon: Icon(Icons.calendar_view_month),
                ),
              ]),
        ),
        const SizedBox(
          height: 15,
        ),
        MouseRegion(
          onEnter: (PointerEvent details) {
            setState(() {
              _isHovering = true;
            });
          },
          onExit: (PointerEvent details) {
            setState(() {
              _isHovering = false;
            });
          },
          child: AnimatedDefaultTextStyle(
            style: TextStyle(
              color: _isHovering ? Colors.greenAccent : Colors.grey,
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            duration: const Duration(milliseconds: 200),
            child: const Text("Up-coming Remainders"),
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          height: 355,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(70.0),
            ),
          ),
          child: TabBarView(controller: tabController, children: const [
            // Center(child: Text("hi")),
            // Center(child: Text("hi")),
            // Center(child: Text("hi")),
            Today(),
            Week(),
            Month(),
          ]),
        ),
        // NavBar()
      ],
    );
  }
}
