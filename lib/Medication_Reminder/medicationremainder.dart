import 'package:calender_picker/calender_picker.dart';
import 'package:care_grantor/Medication_Reminder/addrem.dart';

import 'package:care_grantor/Medication_Reminder/tabBar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

import 'notification_service.dart';

// import 'notification_service.dart';

class MedicationRemainder extends StatefulWidget {
  const MedicationRemainder({Key? key}) : super(key: key);

  @override
  State<MedicationRemainder> createState() => _MedicationRemainderState();
}

class _MedicationRemainderState extends State<MedicationRemainder> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  DatabaseReference medicineRef = FirebaseDatabase.instance.ref().child('medicines');
  late double deviceWidth;
  late double deviceHeight;
  //   @override
  // void initState() {
  //   super.initState();

  //   // Schedule the notification here
  //   NotificationManager.scheduleNotification("medicineName", "7:00 AM");
  // }
// @override
// void initState() {
//   super.initState();
//   sendMedicineReminderNotification();
// }

  

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  width: deviceWidth,
                  height: deviceHeight,
                  child: Column(
                    children: [
                      //text at top
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SafeArea(
                              child: Text(
                                "Medication Remainder",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: 'Open Sans',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // NotificationManager(),

                      const SizedBox(
                        height: 30,
                      ),
                      //horizantal callender
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CalenderPicker(
                            DateTime.now(),
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Colors.black,
                            selectedTextColor: Colors.white,
                            onDateChange: (date) {
                              // New date selected
                              setState(() {
                                var selectedValue = date;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),

                      const TabNav(),
                      // const SizedBox(
                      //   height: 50,
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddRem(
                                      onChanged: (String) {},
                                      options: const [],
                                      option: (String) {},
                                      onChanged1: (String) {},
                                      option1: (String) {},
                                      options1: const [],
                                    )),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue.shade900),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(
                              color: Colors.grey.withOpacity(1),
                              width: 0.7,
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                          ),
                        ),
                        child:  Text('Add remainder',
                        style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700
                            ),),
                      ),
                    ],
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
