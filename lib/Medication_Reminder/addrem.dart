import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/serviceconsumermanagement/v1.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:sa3_liquid/sa3_liquid.dart';

import '../services/notification_services.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class AddRem extends StatefulWidget {
  AddRem({
    Key? key,
    required this.options,
    required this.option,
    required this.onChanged,
    required this.onChanged1,
    required this.options1,
    required this.option1,
  }) : super(key: key);

  @override
  State<AddRem> createState() => _AddRemState();

  List<String> options = const ['Pills', 'Syrup', 'Injection'];
  final Function(String) option;
  final void Function(String) onChanged;
  List<String> options1 = const [
    'BeforeFood',
    'AfterFood',
  ];
  final void Function(String) onChanged1;
  final Function(String) option1;
}

// ignore: non_constant_identifier_names

class _AddRemState extends State<AddRem> {
  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);

    super.initState();
  }

  String? _selectedMedicineType;
  String? _selectedTime;
  bool _btnActive = false;
  bool _isButtonEnabled = false;
  bool _buttonValueMorning = false;
  bool _buttonValueAfterNoon = false;
  bool _buttonValueNight = false;
  bool _daily = false;
  bool _weekly = false;
  bool _monthly = false;
  bool _test = false;

// DateTime now = DateTime.now();
// String timestamp = now.microsecondsSinceEpoch.toString();
  // late final String selectedOption;

  TextEditingController medName = TextEditingController();
  TextEditingController morningButton = TextEditingController();
  TextEditingController medType = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _handleMedicineTypeChanged(String value) {
    setState(() {
      _selectedMedicineType = value;
    });
  }

  void _handleTimeChanged(String value) {
    setState(() {
      _selectedMedicineType = value;
    });
  }

  late double deviceWidth;
  late double deviceHeight;

  String? selectedOption;
  String? _selectedOption1;

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    // bool morningButton;

    return Scaffold(
      key: _scaffoldKey,
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
                      Stack(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 45.5, left: 15.0),
                            child: Text(
                              "Add New Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 50,
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 38.5, left: 317),
                            child: Image.asset(
                                'assets/icons/icons8-medicine-64.png'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: medName,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            labelText: 'Medicine Name',
                            labelStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _btnActive = value.isNotEmpty ? true : false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // String? selectedOption="pills";

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: selectedOption,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'Tablet',
                                    child: Text('Tablet'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Capsule',
                                    child: Text('injection'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Syrup',
                                    child: Text('Syrup'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value;
                                  });
                                  // writeToFirebase(value!);

                                  widget.onChanged(value!);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Medicine Type',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // set border radius
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade800,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                dropdownColor: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // MedicineTypeSelector(
                      //   options: const ['Pills', 'Syrup', 'Injection'],
                      //   // ignore: avoid_types_as_parameter_names
                      //   onChanged: _handleMedicineTypeChanged,
                      //   option: (String) {
                      //     medType;
                      //   },
                      // onChanged: (value) {
                      //     setState(() {
                      //       _btnActive = value.length>=1 ? true : false;
                      //     });
                      //   },
                      // ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Time And Schedule",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButton(
                            onPressed: () {
                              // Do something when the button is pressed
                              // const Text('Morning Button pressed');

                              setState(() {
                                _isButtonEnabled = true;
                                _buttonValueMorning = true;
                              });

                              //                           FirebaseFirestore.instance.collection('medrem').add({
                              //   // 'timestamp': FieldValue.serverTimestamp(),
                              //   'button_name': 'Morning',
                              // });
                            },
                          ),
                          CustomButton1(
                            onPressed: () {
                              // Do something when the button is pressed
                              setState(() {
                                _isButtonEnabled = true;
                                _buttonValueAfterNoon = true;
                              });
                            },
                          ),
                          CustomButton2(
                            onPressed: () {
                              // Do something when the button is pressed
                              notify();
                              setState(() {
                                print("clicked");
                                _isButtonEnabled = true;
                                _buttonValueNight = true;
                                _buttonValueNight == true
                                    ? AwesomeNotifications().createNotification(
                                        content: NotificationContent(
                                            id: 10,
                                            channelKey: 'basic_channel',
                                            title:
                                                'Remainder Scheduled for Night',
                                            body:
                                                'Hi, there this is an information remainder for the remainder set for everyday night',
                                            actionType: ActionType.Default))
                                    : '';
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                value: _selectedOption1,
                                items: const [
                                  DropdownMenuItem(
                                    value: 'BeforeFood',
                                    child: Text('BeforeFood'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'AfterFood',
                                    child: Text('AfterFood'),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption1 = value;
                                  });
                                  widget.onChanged1(value!);
                                },
                                decoration: InputDecoration(
                                  labelText: 'Medicine Time',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // set border radius
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade800,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                dropdownColor: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TimeSelector(
                      //   options1: const [
                      //     'BeforeFood',
                      //     'AfterFood',
                      //   ],
                      //   onChanged1: _handleTimeChanged,
                      // ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DailyButton(
                            onPressed: () {
                              // Do something when the button is pressed
                              setState(() {
                                _isButtonEnabled = true;
                                _daily = true;
                              });
                            },
                          ),
                          WeeklyButton(
                            onPressed: () {
                              // Do something when the button is pressed
                              setState(() {
                                _isButtonEnabled = true;
                                _weekly = true;
                              });
                            },
                          ),
                          MonthlyButton(
                            onPressed: () {
                              // Do something when the button is pressed
                              setState(() {
                                _isButtonEnabled = true;
                                _monthly = true;
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),

                      ElevatedButton(
                        onPressed: () {
                          // String option = selectedOption;
                          Map<String, dynamic> data = {
                            "Medicine Name": medName.text,
                            "Morning Button": _buttonValueMorning,
                            "Medicine Type": selectedOption,
                            "Medicine Time": _selectedOption1,
                            "AfterNoon Button": _buttonValueAfterNoon,
                            "Night Button": _buttonValueNight,
                            "Daily": _daily,
                            "Weekly": _weekly,
                            "Monthly": _monthly,
                            "Test": _test,
                            "order": 1,
                          };
                          FirebaseFirestore.instance
                              .collection(
                                "medrem",
                              )
                              .add(data);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form submitted successfully!'),
                              duration: Duration(seconds: 3),
                            ),
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
                            const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 15,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700),
                        ),
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

  void notify() async {
    String localTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();
    String utcTimeZone =
        await AwesomeNotifications().getLocalTimeZoneIdentifier();

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 0,
            channelKey: 'basic_channel',
            title: 'Notification at exactly every single minute',
            body:
                'This notification was schedule to repeat at every single minute at clock.',
            notificationLayout: NotificationLayout.BigPicture,
            bigPicture: 'asset://assets/images/melted-clock.png'),
        schedule: NotificationCalendar(
            second: 100, timeZone: localTimeZone, repeats: true));
  }
}
// class MedicineTypeSelector extends StatefulWidget {
//   final List<String> options;
//   final Function(String) option;
//   final void Function(String) onChanged;
//   // MedicineTypeSelector({required this.value});

//   const MedicineTypeSelector(
//       {Key? key,
//       required this.options,
//       required this.onChanged,
//       required this.option})
//       : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MedicineTypeSelectorState createState() => _MedicineTypeSelectorState();
// }

// class _MedicineTypeSelectorState extends State<MedicineTypeSelector> {
//   String? selectedOption = "pills";
// //    void writeToFirebase(String option) {
// //   FirebaseFirestore.instance.collection('dropdown_data').add({
// //     'selected_value': option,
// //     'timestamp': FieldValue.serverTimestamp(),
// //   });
// // }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: DropdownButtonFormField<String>(
//               value: selectedOption,
//               items: widget.options
//                   .map((option) => DropdownMenuItem(
//                         value: option,
//                         child: Text(option),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedOption = value;
//                 });
//                 // writeToFirebase(value!);
//                 widget.onChanged(value!);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Medicine Type',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: const BorderSide(color: Colors.white),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(10.0), // set border radius
//                   borderSide: const BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.black45,
//               ),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//               ),
//               dropdownColor: Colors.grey[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomButton extends StatefulWidget {
  final void Function() onPressed;

  const CustomButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Morning', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class CustomButton1 extends StatefulWidget {
  final void Function() onPressed;

  const CustomButton1({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState1 createState() => _CustomButtonState1();
}

class _CustomButtonState1 extends State<CustomButton1> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Afternoon', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class CustomButton2 extends StatefulWidget {
  final void Function() onPressed;

  const CustomButton2({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState2 createState() => _CustomButtonState2();
}

class _CustomButtonState2 extends State<CustomButton2> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Night', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class CustomButton3 extends StatefulWidget {
  final void Function() onPressed;

  const CustomButton3({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomButtonState2 createState() => _CustomButtonState2();
}

class _CustomButtonState3 extends State<CustomButton3> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Test', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

// class TimeSelector extends StatefulWidget {
//   final List<String> options1;
//   final void Function(String) onChanged1;

//   const TimeSelector({
//     Key? key,
//     required this.options1,
//     required this.onChanged1,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _TimeSelectorState createState() => _TimeSelectorState();
// }

// class _TimeSelectorState extends State<TimeSelector> {
//   String? _selectedOption1;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: DropdownButtonFormField<String>(
//               value: _selectedOption1,
//               items: widget.options1
//                   .map((option1) => DropdownMenuItem(
//                         value: option1,
//                         child: Text(option1),
//                       ))
//                   .toList(),
//               onChanged: (value) {
//                 setState(() {
//                   _selectedOption1 = value;
//                 });
//                 widget.onChanged1(value!);
//               },
//               decoration: InputDecoration(
//                 labelText: 'Medicine Type',
//                 labelStyle: const TextStyle(color: Colors.white),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: const BorderSide(color: Colors.white),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(10.0), // set border radius
//                   borderSide: const BorderSide(color: Colors.white),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.white),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.black45,
//               ),
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 16.0,
//               ),
//               dropdownColor: Colors.grey[800],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DailyButton extends StatefulWidget {
  final void Function() onPressed;

  const DailyButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DailyButtonState createState() => _DailyButtonState();
}

class _DailyButtonState extends State<DailyButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Daily', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class WeeklyButton extends StatefulWidget {
  final void Function() onPressed;

  const WeeklyButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WeeklyButtonState createState() => _WeeklyButtonState();
}

class _WeeklyButtonState extends State<WeeklyButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Weekly', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

class MonthlyButton extends StatefulWidget {
  final void Function() onPressed;

  const MonthlyButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonthlyButtonState createState() => _MonthlyButtonState();
}

class _MonthlyButtonState extends State<MonthlyButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    Color color = _isSelected ? Colors.green : Colors.grey[400]!;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onPressed();
      },
      child: Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Icon(Icons.add, color: Colors.white),
            // SizedBox(width: 10),
            Text('Monthly', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

// void _submit() {
 
// }


