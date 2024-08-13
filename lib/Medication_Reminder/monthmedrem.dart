// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:sa3_liquid/sa3_liquid.dart';

class Month extends StatefulWidget {
  const Month({Key? key}) : super(key: key);

  @override
  State<Month> createState() => _MonthState();
}

class _MonthState extends State<Month> {
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: deviceWidth,
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
                        //Container that contains upcomming remainders
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(height: 30),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              //Remainder Item in container
                              child: Column(
                                children: [
                                  Container(
                                    height: 60,
                                    width: deviceWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    //Medicine description and Type
                                    child: Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Image.asset(
                                              'assets/icons/icons8-pills-48.png'),
                                        ),
                                        const SizedBox(width: 75),
                                        const Text(
                                          "paracetamol",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: 60,
                                    width: deviceWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Image.asset(
                                              'assets/icons/icons8-syrup-53.png'),
                                        ),
                                        const SizedBox(width: 75),
                                        const Text(
                                          "Crocin",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    height: 60,
                                    width: deviceWidth,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Image.asset(
                                              'assets/icons/icons8-injection-53.png'),
                                        ),
                                        const SizedBox(width: 75),
                                        const Text(
                                          "Insulin",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Open Sans',
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
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
