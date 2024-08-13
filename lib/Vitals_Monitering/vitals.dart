// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googleapis/fitness/v1.dart';
// import 'package:googleapis_auth/auth.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_auth/http_auth.dart';

// Future<void> fetchDataFromGoogleFit() async {
//   // final GoogleSignIn googleSignIn = GoogleSignIn(
//   //   scopes: <String>[
//   //     'email',
//   //     'https://www.googleapis.com/auth/fitness.activity.read',
//   //   ],
//   // );
//   final authClient = await googleSignIn.authenticatedClient();
//   final fitnessApi = FitnessApi(!authclient);

  // final GoogleSignInAccount? currentUser = await googleSignIn.signIn();
  // final GoogleSignInAuthentication authentication =
      // await currentUser!.authentication;
  // final GoogleSignInAuthentication auth = await currentUser!.authentication;

  // final accessToken = authentication.accessToken;

  // final headers = {
  //   'Authorization': 'Bearer $accessToken',
  // };

  // final response = await http.get(
  //   'https://www.googleapis.com/fitness/v1/users/me/dataSources' as Uri,
  //   headers: headers,
  // );
  // final auth = await currentUser?.authentication;
  // final authHeaders = auth?.headers;

  // final authClient = BasicAuthClient(authHeaders['Authorization']!, '');
// }


// final authClient = await googleSignIn.currentUser.authenticatedClient();
// final authClient = await googleSignIn.currentUser?.authenticatedClient();


// final fitnessApi = FitnessApi(authClient);

import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:firebase_database/firebase_database.dart';

class Vitals extends StatefulWidget {
  const Vitals({required this.date, required this.rate});
  final String date;
  final int rate;

  // Vitals(this.date, this.rate);

  @override
  State<Vitals> createState() => _VitalsState();
}

class _VitalsState extends State<Vitals> {
  final List<Vitals> _data = [
    const Vitals(date: '01/01/2022', rate: 70),
    const Vitals(date: '01/02/2022', rate: 75),
    const Vitals(date: '01/03/2022', rate: 80),
    const Vitals(date: '01/04/2022', rate: 85),
    const Vitals(date: '01/05/2022', rate: 90),
    const Vitals(date: '01/06/2022', rate: 95),
    const Vitals(date: '01/07/2022', rate: 100),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Vitals, String>> series = [
      charts.Series(
        id: 'Heart Rate',
        data: _data,
        domainFn: (Vitals data, _) => data.date,
        measureFn: (Vitals data, _) => data.rate,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];

     return Scaffold(
      // appBar: AppBar(
      //   title: Text('Heart Rate'),
      // ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Heart Rate',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                height: 150, // Set the height to a fixed value
                child: charts.BarChart(
                  series,
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  behaviors: [
                    charts.SeriesLegend(
                      position: charts.BehaviorPosition.top,
                      showMeasures: true,
                      measureFormatter: (num? value) {
                        return value.toString() + ' bpm';
                      },
                    ),
                  ],
                  domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                      labelRotation: 45,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:health/health.dart';

// class DailyStepsScreen extends StatefulWidget {
//   const DailyStepsScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _DailyStepsScreenState createState() => _DailyStepsScreenState();
// }

// enum AppState {
//   DATA_NOT_FETCHED,
//   FETCHING_DATA,
//   DATA_READY,
//   NO_DATA,
//   AUTH_NOT_GRANTED
// }
// // double value = healthValue.value.toDouble();

// class _DailyStepsScreenState extends State<DailyStepsScreen> {
//   List<HealthDataPoint> _healthDataList = [];
//   AppState _state = AppState.DATA_NOT_FETCHED;

//   @override
//   void initState() {
//     super.initState();
//   }


//   Future<void> fetchData() async {
//     /// Get everything from midnight until now
//     DateTime startDate = DateTime(2020, 11, 07, 0, 0, 0);
//     DateTime endDate = DateTime(2025, 11, 07, 23, 59, 59);

//     HealthFactory health = HealthFactory();

//     /// Define the types to get.
//     List<HealthDataType> types = [
//       HealthDataType.STEPS,
//       HealthDataType.WEIGHT,
//       HealthDataType.HEIGHT,
//       HealthDataType.BLOOD_GLUCOSE,
//       HealthDataType.DISTANCE_WALKING_RUNNING,
//     ];

//     setState(() => _state = AppState.FETCHING_DATA);

//     /// You MUST request access to the data types before reading them
//     bool accessWasGranted = await health.requestAuthorization(types);

//     num steps = 0;
//     // double value = healthDataPoint.value.toDouble();

//     if (accessWasGranted) {
//       try {
//         /// Fetch new data
//         List<HealthDataPoint> healthData =
//         await health.getHealthDataFromTypes(startDate, endDate, types);

//         /// Save all the new data points
//         _healthDataList.addAll(healthData);
//       } catch (e) {
//         print("Caught exception in getHealthDataFromTypes: $e");
//       }

//       /// Filter out duplicates
//       _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

//       /// Print the results
//       _healthDataList.forEach((x) {
//         print("Data point: $x");
//          steps += x.value as num;
//       });

//       print("Steps: $steps");

//       /// Update the UI to display the results
//       setState(() {
//         _state =
//         _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
//       });
//     } else {
//       print("Authorization not granted");
//       setState(() => _state = AppState.DATA_NOT_FETCHED);
//     }
//   }

//   Widget _contentFetchingData() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//             padding: EdgeInsets.all(20),
//             child: CircularProgressIndicator(
//               strokeWidth: 10,
//             )),
//         Text('Fetching data...')
//       ],
//     );
//   }

//   Widget _contentDataReady() {
//     return ListView.builder(
//         itemCount: _healthDataList.length,
//         itemBuilder: (_, index) {
//           HealthDataPoint p = _healthDataList[index];
//           return ListTile(
//             title: Text("${p.typeString}: ${p.value}"),
//             trailing: Text('${p.unitString}'),
//             subtitle: Text('${p.dateFrom} - ${p.dateTo}'),
//           );
//         });
//   }

//   Widget _contentNoData() {
//     return Text('No Data to show');
//   }

//   Widget _contentNotFetched() {
//     return Text('Press the download button to fetch data');
//   }

//   Widget _authorizationNotGranted() {
//     return Text('''Authorization not given.
//         For Android please check your OAUTH2 client ID is correct in Google Developer Console.
//          For iOS check your permissions in Apple Health.''');
//   }

//   Widget _content() {
//     if (_state == AppState.DATA_READY)
//       return _contentDataReady();
//     else if (_state == AppState.NO_DATA)
//       return _contentNoData();
//     else if (_state == AppState.FETCHING_DATA)
//       return _contentFetchingData();
//     else if (_state == AppState.AUTH_NOT_GRANTED)
//       return _authorizationNotGranted();

//     return _contentNotFetched();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           appBar: AppBar(
//             title: const Text('Plugin example app'),
//             actions: <Widget>[
//               IconButton(
//                 icon: const Icon(Icons.file_download),
//                 onPressed: () {
//                   fetchData();
//                 },
//               )
//             ],
//           ),
//           body: Center(
//             child: _content(),
//           )
//     );

//   }
// }