import 'dart:async';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'chatmessage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<ChatMessage> _message = [];
  String apiKey = "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";
  Future<void> _sendMessage() async {
    ChatMessage message = ChatMessage(
        text: _controller.text,
        sender: "user",
        style: const TextStyle(
          color: Colors.white,
        ));
    // Refresh the page
    setState(() {
      _message.insert(0, message);
    });
    // clear the user input from text-field
    _controller.clear();
    // Call the generateText method and store result into response
    final response = await generateText(message.text);
    // Create Create ChatMessage Class object and pass the bot output
    // ChatMessage botMessage =
    //     ChatMessage(text: response.toString(), sender: "bot");
    ChatMessage botMessage = ChatMessage(
        text: response.toString(),
        sender: "bot",
        style: const TextStyle(color: Colors.white));

    // Refresh the page
    setState(() {
      _message.insert(0, botMessage);
    });
  }

  Future<String> generateText(String prompt) async {
    try {
      Map<String, dynamic> requestBody = {
        "model": "text-davinci-003",
        "prompt": prompt,
        "temperature": 0,
        "max_tokens": 100,
      };
      var url = Uri.parse('https://api.openai.com/v1/completions');
      var response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $apiKey"
          },
          body: json.encode(requestBody)); // post call
      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);
        return responseJson["choices"][0]["text"];
      } else {
        return "Failed to generate text: ${response.body}";
      }
    } catch (e) {
      return "Failed to generate text: $e";
    }
  }

  Widget _buidTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Send a message",
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            _sendMessage();
          },
          icon: const Icon(
            Icons.send,
            color: Colors.greenAccent,
          ),
        )
      ],
    ).px24();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(32, 24, 23, 23),
      body: Container(
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
        child: SafeArea(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                padding: Vx.m20,
                reverse: true,
                itemBuilder: (context, index) {
                  return _message[index];
                },
                itemCount: _message.length,
              )),
              const Divider(
                height: 1.5,
              ),
              Container(
                decoration: const BoxDecoration(),
                child: _buidTextComposer(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
