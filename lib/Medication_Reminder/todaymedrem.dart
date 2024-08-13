import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
import 'dart:core';
import 'package:care_grantor/main.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MedicationReminder {
  String medicineName;
  TimeOfDay time;
  DateTime date;

  MedicationReminder(
      {required this.medicineName, required this.time, required this.date});
}

class Today extends StatefulWidget {
  const Today({Key? key}) : super(key: key);

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // final String _medicineName = '';
  // final TimeOfDay _timeOfDay = TimeOfDay.now();
  // final DateTime _dateTime = DateTime.now();
  // List<MedicationReminder> _medicationReminders = [];

  late double deviceWidth;
  late double deviceHeight;
  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
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
            color: Color.fromARGB(32, 24, 23, 23),
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
              child: SizedBox(
                  width: deviceWidth,
                  height: double.maxFinite,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('medrem')
                        .where('Daily', isEqualTo: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // If there is no data, return an empty container
                        return Container(
                          width: deviceWidth,
                          // color: Colors.black,
                          height: 320,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40.0),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromARGB(206, 86, 81, 81),
                                Color.fromARGB(142, 92, 92, 92),
                                Color.fromARGB(123, 6, 6, 6)
                                // Colors.blueGrey,
                              ],
                            ),
                          ),
                        );
                      }
                      // Otherwise, build the container with the fetched data
                      final documents = snapshot.data!.docs;
                      return Container(
                        height: 30,
                        // width: deviceWidth,
                        decoration: const BoxDecoration(
                          // color: Colors.white.withOpacity(0.6),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(206, 86, 81, 81),
                              Color.fromARGB(142, 92, 92, 92),
                              Color.fromARGB(123, 6, 6, 6)
                              // Colors.blueGrey,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        //Medicine description and Type
                        child: Row(
                          // mainAxisAlignment:
                          //     MainAxisAlignment.spaceAround,
                          children: [
                            // SizedBox(height: 30,),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10.0),
                            //   child: Image.asset(
                            //       'assets/icons/icons8-pills-48.png'),
                            // ),
                            // const SizedBox(width: 75),
                            Expanded(
                              child: ListView.builder(
                                // scrollDirection: Axis.horizontal,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  final medicineName = documents[index]
                                      ['Medicine Name'] as String;
                                  // _medicationReminders.add(medicineName as MedicationReminder);
                                  final medicineType = documents[index]
                                      ['Medicine Type'] as String;
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 60,
                                      width: deviceWidth,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                          ),
                                          Container(
                                              width: 75,
                                              // width: MediaQuery.of(context)
                                              //     .size
                                              //     .width-200, // Set a specific width, e.g., the screen width

                                              child: ListView.builder(
                                                itemCount: 3, // Number of items
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  Widget medicineImage;

                                                  switch (medicineType) {
                                                    case "Tablet":
                                                      medicineImage = SizedBox(
                                                        child: Image.asset(
                                                          'assets/icons/icons8-pills-48.png',
                                                          // width: 100,
                                                          // height: 100,
                                                        ),
                                                      );
                                                      break;
                                                    case "Syrup":
                                                      medicineImage =
                                                          Image.asset(
                                                        'assets/icons/icons8-syrup-53.png',
                                                      );
                                                      break;
                                                    default:
                                                      medicineImage =
                                                          Image.asset(
                                                        'assets/icons/icons8-injection-53.png',
                                                      ); // Placeholder widget
                                                  }

                                                  return ListTile(
                                                    title: medicineImage,
                                                  );
                                                },
                                              )),
                                          const SizedBox(width: 75),
                                          Text(
                                            medicineName,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'Open Sans',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )

                  // Column(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 15),
                  //       child: Container(
                  //         width: deviceWidth,
                  //         height: 320,
                  //         decoration: const BoxDecoration(
                  //           borderRadius: BorderRadius.all(
                  //             Radius.circular(40.0),
                  //           ),
                  //           gradient: LinearGradient(
                  //             begin: Alignment.topLeft,
                  //             end: Alignment.bottomRight,
                  //             colors: [
                  //               Color.fromARGB(206, 86, 81, 81),
                  //               Color.fromARGB(142, 92, 92, 92),
                  //               Color.fromARGB(123, 6, 6, 6)
                  //               // Colors.blueGrey,
                  //             ],
                  //           ),
                  //         ),
                  //         //Container that contains upcomming remainders
                  //         child: Column(
                  //           // crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             const SizedBox(height: 30),
                  //             Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               //Remainder Item in container
                  //               child: Column(
                  //                 children: [
                  //                   Container(
                  //                     height: 60,
                  //                     width: deviceWidth,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.6),
                  //                       borderRadius: const BorderRadius.all(
                  //                         Radius.circular(20.0),
                  //                       ),
                  //                     ),
                  //                     //Medicine description and Type
                  //                     child: Row(
                  //                       // mainAxisAlignment:
                  //                       //     MainAxisAlignment.spaceAround,
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                               const EdgeInsets.only(left: 10.0),
                  //                           child: Image.asset(
                  //                               'assets/icons/icons8-pills-48.png'),
                  //                         ),
                  //                         const SizedBox(width: 75),
                  //                         const Text(
                  //                           "paracetamol",
                  //                           style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: 'Open Sans',
                  //                               fontSize: 20,
                  //                               fontWeight: FontWeight.w600),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 30,
                  //                   ),
                  //                   Container(
                  //                     height: 60,
                  //                     width: deviceWidth,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.6),
                  //                       borderRadius: const BorderRadius.all(
                  //                         Radius.circular(20.0),
                  //                       ),
                  //                     ),
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                               const EdgeInsets.only(left: 10.0),
                  //                           child: Image.asset(
                  //                               'assets/icons/icons8-syrup-53.png'),
                  //                         ),
                  //                         const SizedBox(width: 75),
                  //                         const Text(
                  //                           "Crocin",
                  //                           style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: 'Open Sans',
                  //                               fontSize: 20,
                  //                               fontWeight: FontWeight.w600),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 30,
                  //                   ),
                  //                   Container(
                  //                     height: 60,
                  //                     width: deviceWidth,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white.withOpacity(0.6),
                  //                       borderRadius: const BorderRadius.all(
                  //                         Radius.circular(20.0),
                  //                       ),
                  //                     ),
                  //                     child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                       children: [
                  //                         Padding(
                  //                           padding:
                  //                               const EdgeInsets.only(left: 10.0),
                  //                           child: Image.asset(
                  //                               'assets/icons/icons8-injection-53.png'),
                  //                         ),
                  //                         const SizedBox(width: 75),
                  //                         const Text(
                  //                           "Insulin",
                  //                           style: TextStyle(
                  //                               color: Colors.black,
                  //                               fontFamily: 'Open Sans',
                  //                               fontSize: 20,
                  //                               fontWeight: FontWeight.w600),
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationManager {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  String medicineName = '';

  Future<void> fetchMedicineName() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('medrem')
          .where('Daily', isEqualTo: true)
          .get();

      if (snapshot.docs.isNotEmpty) {
        medicineName = snapshot.docs[0].get('MedicineName');
        print('Medicine Name: $medicineName');
      } else {
        print('No documents found');
      }
    } catch (e) {
      print('Error fetching medicine name: $e');
    }
  }

  static Future<void> showNotification(String medicineName) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Medication Reminder',
      'Take your medicine: $medicineName',
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }

  static Future<void> scheduleNotification(
      String medicineName, DateTime dateTime) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Medication Reminder',
      'Take your medicine: $medicineName',
      tz.TZDateTime.from(dateTime, tz.local),
      platformChannelSpecifics,
      payload: 'notification_payload',
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
