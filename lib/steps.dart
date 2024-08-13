import 'package:flutter/material.dart';
import 'package:sa3_liquid/sa3_liquid.dart';
import 'package:sensors_plus/sensors_plus.dart';
// import 'package:sensors/sensors.dart';

class Steps extends StatefulWidget {
  const Steps({super.key});

  @override
  State<Steps> createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  int _stepsCount = 0;
  int _goalStepsCount = 10000;
  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      final double y = event.y;
      final double x = event.x;
      // final double z = event.z;
      if (y > 15 || x > 15 ) {
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

  @override
  Widget build(BuildContext context) {
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
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
            color: const Color.fromARGB(59, 2, 8, 82),
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
                width: deviceWidth - 100,
                height: deviceHeight - 100,
                child: Column(
                  children: [
                    const Text(
                      'Steps Walked:',
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '$_stepsCount',
                      style: const TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 100.0,
                      width: 95.0,
                      child: CircularProgressIndicator(
                        strokeWidth: 8.0,
                        value: progressPercentage,
                        backgroundColor: Colors.grey,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.greenAccent),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'Goal: $_goalStepsCount steps',
                      style:
                          const TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                        child: const Text('Set Goal'),
                        onPressed: () async {
                          int newGoal = 0;
                          final result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Set Goal'),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    newGoal = int.tryParse(value) ?? 0;
                                  },
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context, null);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue.shade900),
                                      side:
                                          MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                          color: Colors.grey.withOpacity(1),
                                          width: 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    child: const Text('Save'),
                                    onPressed: () {
                                      Navigator.pop(context, newGoal);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue.shade900),
                                      side:
                                          MaterialStateProperty.all<BorderSide>(
                                        BorderSide(
                                          color: Colors.grey.withOpacity(1),
                                          width: 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                          if (result != null) {
                            setState(() {
                              _goalStepsCount = result;
                            });
                          }
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
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
