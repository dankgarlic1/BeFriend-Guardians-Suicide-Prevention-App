import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
// import 'package:guardians_suicide_prevention_app/presentation/screens/sos/emergencyCall.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/ads/ads.dart';
import 'chat_messagesUI.dart';

class ChatModel extends StatefulWidget {
  const ChatModel({super.key});

  @override
  State<ChatModel> createState() => _ChatModelState();
}

class _ChatModelState extends State<ChatModel> {
  final TextEditingController _prompts = TextEditingController();
  final List<ChatMessageUI> _messages = [];
  bool isLoading = false;

  final _textFieldStreamController = StreamController<String>();
  Stream<String> get textFieldStream => _textFieldStreamController.stream;

  @override
  void initState() {
    super.initState();
    Ads().showInterstitialAd();

    // Initialize SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      final bool understood = prefs.getBool('understood') ?? false;

      if (!understood) {
        // Show an initial alert dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Disclaimer"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "This AI chat bot is not a replacement for professional help. If your situation is critical, please seek immediate assistance from a qualified professional.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        prefs.setBool('understood',
                            true); // Store the user's understanding
                      },
                      child: Text(
                        "I Understand",
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple[500], // Button color
                        onPrimary: Colors.white, // Text color
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }

      ChatMessageUI opening1 = ChatMessageUI(
        text: 'This is a safe space, we can talk about your feelings safely',
        sender: 'Therapist',
      );
      ChatMessageUI opening2 = ChatMessageUI(
        text:
            'Enter "Help!" for calling Suicide HelpLine number immediately from here itself',
        sender: 'Therapist',
      );
      setState(() {
        _messages.insert(0, opening1);
        _messages.insert(0, opening2);
      });

      _prompts.addListener(() {
        _textFieldStreamController.add(_prompts.text);
      });
    });
  }

  void _addMessage(String text, String sender) {
    ChatMessageUI message = ChatMessageUI(text: text, sender: 'User');
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> sendGptRequest(String userMessage) async {
    final apiKey = dotenv.env['API_KEY'];
    final apiUrl = dotenv.env['API_URL'];

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    final requestBody = {
      "model": dotenv.env['FINE_TUNING_MODEL'],
      "messages": [
        {
          "role": "user",
          "content": userMessage,
        }
      ],
      "temperature": 1.3,
      "max_tokens": 256,
      "top_p": 1,
      "frequency_penalty": 0.95,
      "presence_penalty": 1.1,
    };

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      Uri.parse(apiUrl??'deaf'),
      headers: headers,
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final assistantResponse =
          responseBody['choices'][0]['message']['content'];
      ChatMessageUI aimessage = ChatMessageUI(
        text: assistantResponse,
        sender: 'Therapist',
      );

      setState(() {
        _messages.insert(0, aimessage);
      });

      await Future.delayed(Duration(seconds: 2));

      setState(() {
        isLoading = false;
      });
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  void makeEmergencyCall() async {
    final Uri url = Uri(
      scheme: 'tel',
      path: '9152987821',
    );
    final String urlString = url.toString();
    if (await canLaunch(urlString)) {
      await launch(urlString);
    } else {
      print('Can\'t Launch');
    }
  }

  Widget _text_field() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 65,
            child: SingleChildScrollView(
              child: TextField(
                maxLines: null,
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _addMessage(value, 'User');
                    sendGptRequest(value);
                    _prompts.clear();
                  }
                },
                controller: _prompts,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'You can Open Up here...',
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  contentPadding: EdgeInsets.only(left: 8),
                ),
              ),
            ),
          ),
        ),
        StreamBuilder<String>(
          stream: textFieldStream,
          builder: (context, snapshot) {
            return InkWell(
              onTap: () {
                // Check if the user's message is an emergency request
                String userMessage = _prompts.text.toLowerCase();
                if (userMessage == 'help!' ||
                    userMessage == 'Help!' ||
                    userMessage == 'HELP!') {
                  makeEmergencyCall();
                  _prompts.clear();
                } else {
                  // Send the user's message to GPT
                  _addMessage(_prompts.text, 'User');
                  sendGptRequest(_prompts.text);
                  _prompts.clear();
                }
              },
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: snapshot.data?.isEmpty ?? true
                      ? Colors.grey[200]
                      : Colors.deepPurple,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  size: 35,
                  Icons.send_sharp,
                  color: snapshot.data?.isEmpty ?? true
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    Ads.rewardedAd?.dispose();
    _textFieldStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[50],
        title: Text(
          "Personal ChatBot",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              if (isLoading == true)
                LinearProgressIndicator(
                  backgroundColor: Colors.deepPurple,
                  color: Colors.blue,
                ),
              Divider(
                height: 1,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                  child: _text_field(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
