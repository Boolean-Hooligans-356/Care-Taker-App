import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'chat_screen.dart';

// class AIAssistant extends StatelessWidget {
//   const AIAssistant({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     WidgetsFlutterBinding.ensureInitialized();
//     dotenv.load(fileName: ".env");
//     return Scaffold(
//       // title: 'ChatGPT Demo',
//       // debugShowCheckedModeBanner: false,
//       // theme: ThemeData(
//       //   primarySwatch: Colors.green,
//       //   useMaterial3: true,
//       // ),
//       body: const ChatScreen(),
//     );
//   }
// }

class AIAssistant extends StatelessWidget {
  const AIAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    dotenv.load(fileName: ".env");
    return Scaffold(
        body: Stack(
      children: [
        const ChatScreen(),
        // const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 45.0, left: 15.0),
              child: Text(
                "Your Medical Companion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Open Sans',
                ),
              ),
            ),
          ],
        ),
        
      ],
    )
         
        );
  }
}
