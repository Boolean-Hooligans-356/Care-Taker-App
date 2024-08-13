// import 'package:care_grantor/bottomdrawer.dart';
import 'package:care_grantor/steps.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
import 'package:sensors_plus/sensors_plus.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
// import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> { @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      final double y = event.y;
      if (y > 15) {
        setState(() {
          _stepsCount++;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerEvents.drain();
  }

  double get progressPercentage => _stepsCount / _goalStepsCount;
  late double deviceWidth;
  late double deviceHeight;
  int _stepsCount = 0;
  int _goalStepsCount = 10000;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //       appBar: NewGradientAppBar(
        //   title: const Text('Welcome Back'),
        //   gradient: const LinearGradient(colors: [Color.fromARGB(206, 229, 179, 30),Color.fromARGB(178, 180, 142, 28)])
        // ),
        // bottomNavigationBar: NavBar(),
        // backgroundColor: Colors.black,
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                tileMode: TileMode.mirror,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 29, 28, 28),
                  // Color(0x596164FF),
                  Color.fromARGB(255, 33, 33, 33),
                ],
                stops: [
                  0,
                  1,
                ],
              ),
              backgroundBlendMode: BlendMode.srcOver,
            ),
            child: PlasmaRenderer(
              type: PlasmaType.infinity,
              particles: 20,
              color: const Color.fromARGB(32, 24, 23, 23),
              blur: 0.3,
              size: 0,
              speed: 0,
              offset: 0,
              blendMode: BlendMode.plus,
              particleType: ParticleType.atlas,
              variation1: 1,
              variation2: 0,
              variation3: 0,
              rotation: 0,
              child: SizedBox(
                height: deviceHeight,
                width: deviceWidth,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: SafeArea(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top:10.0,left:15.0),
                                child: Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Open Sans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                      //     // const AnimatedCount(
                      //     //   count: 90,
                      //     //   unit: '%',
                      //     //   duration: Duration(milliseconds: 500),
                      //     // ),
                      //     const Text(
                      //   'Steps Walked:',
                      //   style: TextStyle(
                      //     fontSize: 24.0,
                      //     color: Colors.white
                      //   ),
                      // ),
                      // const SizedBox(height: 8.0),
                      // Text(
                      //   '$_stepsCount',
                      //   style: const TextStyle(
                      //     fontSize: 30.0,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white
                      //   ),
                      // ),
                      // const SizedBox(height: 16.0),
                      // SizedBox(
                      //   height: 100.0,
                      //   width: 150.0,
                      //   child: CircularProgressIndicator(
                      //     strokeWidth: 8.0,
                      //     value: progressPercentage,
                      //     backgroundColor: Colors.grey,
                      //     valueColor: const AlwaysStoppedAnimation<Color>(
                      //         Colors.greenAccent),
                      //   ),
                      // ),
                      // const SizedBox(height: 16.0),
                      // Text(
                      //   'Goal: $_goalStepsCount steps',
                      //   style: const TextStyle(
                      //     fontSize: 24.0,
                      //     color: Colors.white
                      //   ),
                      // ),
                      // const SizedBox(height: 8.0),
                      // ElevatedButton(
                      //   child: const Text('Set Goal'),
                      //   onPressed: () async {
                      //     int newGoal = 0;
                      //     final result = await showDialog(
                      //       context: context,
                      //       builder: (context) {
                      //         return AlertDialog(
                      //           title: const Text('Set Goal'),
                      //           content: TextField(
                      //             keyboardType: TextInputType.number,
                      //             onChanged: (value) {
                      //               newGoal = int.tryParse(value) ?? 0;
                      //             },
                      //           ),
                      //           actions: [
                      //             ElevatedButton(
                      //               child: const Text('Cancel'),
                      //               onPressed: () {
                      //                 Navigator.pop(context, null);
                      //               },
                      //             ),
                      //             ElevatedButton(
                      //               child: const Text('Save'),
                      //               onPressed: () {
                      //                 Navigator.pop(context, newGoal);
                      //               },
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //     if (result != null) {
                      //       setState(() {
                      //         _goalStepsCount = result;
                      //       });
                      //     }
                      //   },
                      // ),

                          SizedBox(
                            width: deviceWidth,
                            height: deviceHeight-500,
                            child: const Steps()),

                          //
                          // const SizedBox(height: 30),
                          // const SizedBox(
                          //   width: 200,
                          //   child: CircleProgressBar(
                          //     foregroundColor: Color.fromARGB(255, 59, 164, 65),
                          //     backgroundColor: Colors.black12,
                          //     value: 0.5,
                          //     child: Center(
                          //       child: Text(
                          //         "5000",
                          //         style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: 30,
                          //             fontFamily: 'Open Sans',
                          //             fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          // const Text(
                          //   "Steps Walked",
                          //   style: TextStyle(
                          //     color: Colors.white,
                          //     fontSize: 15,
                          //     fontFamily: 'Open Sans',
                          //   ),
                          // ),
                          // const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 60,
                                  width: deviceWidth-16,
                                  alignment: FractionalOffset.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Name:jack",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          color: Colors.black26.withAlpha(150)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 60,
                                  width: deviceWidth-16,
                                  alignment: FractionalOffset.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Age:50",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          color: Colors.black26.withAlpha(150)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 60,
                                  width: deviceWidth -16,
                                  alignment: FractionalOffset.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Blood-Group:B+",
                                      style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontStyle: FontStyle.italic,
                                          fontSize: 25,
                                          color: Colors.black26.withAlpha(150)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  height: 60,
                                  width: deviceWidth -16,
                                  alignment: FractionalOffset.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Height:5'10",
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 25,
                                              color:
                                                  Colors.black26.withAlpha(150)),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          "Weight:165lbs",
                                          style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 25,
                                              color:
                                                  Colors.black26.withAlpha(150)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
