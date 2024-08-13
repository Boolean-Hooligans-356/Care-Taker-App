import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';

class Sos extends StatefulWidget {
  const Sos({Key? key}) : super(key: key);

  @override
  State<Sos> createState() => _SosState();
}

class _SosState extends State<Sos> {
  // final TextEditingController _numberCtrl = TextEditingController();
  late double deviceWidth;
  late double deviceHeight;
  final contacts = <String>[];
  bool isSosEnabled = false;
  bool isCallingEnabled = true;
  bool isSMSEnabled = true;
  bool _callPermissionGranted = false;
  bool _smsPermissionGranted = false;
  Timer? _sosTimer;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
    accelerometerEvents.listen((event) {
      if (isSosEnabled &&
          (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 15)) {
        if (_sosTimer == null || !_sosTimer!.isActive) {
          if (isSMSEnabled) {
            _getCurrentLocation().then((position) {
              sendingSMS(
                  'Help! I need assistance. \n My location is ${position.latitude},${position.longitude}.',
                  contacts);
            });
          }
          if (isCallingEnabled) {
            _makePhoneCall(contacts.first);
          }
          _sosTimer = Timer(const Duration(seconds: 60), () {
            _sosTimer = null;
          });
        }
      }
    });
  }

  Future<void> _requestPermissions() async {
    final callPermission = await Permission.phone.request();
    final smsPermission = await Permission.sms.request();
    final locationPermission = await Permission.location.request();
    setState(() {
      _callPermissionGranted = callPermission == PermissionStatus.granted;
      _smsPermissionGranted = smsPermission == PermissionStatus.granted;
    });
  }

  Future<Position> _getCurrentLocation() async {
    final Geolocator geolocator = Geolocator();
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void sendingSMS(String msg, List<String> listRecipients) async {
    if (_smsPermissionGranted) {
      try {
        String sendResult = await sendSMS(
            message: msg, recipients: listRecipients, sendDirect: true);
        print(sendResult);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    if (_callPermissionGranted) {
      try {
        await FlutterPhoneDirectCaller.callNumber(phoneNumber);
      } catch (e) {
        throw 'Could not launch $phoneNumber';
      }
    }
  }

  void _showAddContactDialog() {
    String newContact = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Contact'),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
          onChanged: (value) => newContact = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                contacts.add(newContact);
              });
              Navigator.pop(context);
            },
            child: const Text('ADD'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 55.0),
                            child: Text(
                              'SOS',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 60,
                              width: deviceWidth / 1.8,
                              alignment: FractionalOffset.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Enable Calling',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Open Sans',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Switch(
                                    value: isCallingEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        isCallingEnabled = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //
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
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 60,
                              width: deviceWidth / 1.8,
                              alignment: FractionalOffset.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Enable SMS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Open Sans',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 27,
                                  ),
                                  Switch(
                                    value: isSMSEnabled,
                                    onChanged: (value) {
                                      setState(() {
                                        isSMSEnabled = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            //
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ElevatedButton(
                              onPressed: _showAddContactDialog,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                '+  Contacts',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 15,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                itemCount: contacts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                      contacts[index],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          contacts.removeAt(index); 
                                        });
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 60,
                              width: deviceWidth / 1.8,
                              alignment: FractionalOffset.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.75),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'SOS is ${isSosEnabled ? 'enabled' : 'disabled '}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Open Sans',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isSosEnabled = !isSosEnabled;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
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
                                isSosEnabled ? 'Disable SOS' : 'Enable SOS',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 15,
                                    fontFamily: 'Open Sans',
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ],
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
