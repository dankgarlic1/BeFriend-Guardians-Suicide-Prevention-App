import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class ChatMessageUI extends StatelessWidget {
  const ChatMessageUI({super.key, required this.text, required this.sender});
  final String text;
  final String sender;


  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Column(
            crossAxisAlignment: sender=='User'? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: sender=='User'?
                EdgeInsets.only(left: 50, bottom: 5, right: 15, top: 5)
                    : EdgeInsets.only(left: 15, bottom: 5, right: 50, top: 5),

                child: sender=='User'? Text('User',style: TextStyle(fontWeight: FontWeight.bold),
                ):Text('ChatBot',style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onLongPress: () => copyToClipboard(context, text),
                child: Container(
                  margin: sender=='User'?
                  EdgeInsets.only(left: 10, bottom: 5, right: 15, top: 2)
                      : EdgeInsets.only(left: 15, bottom: 5, right: 10, top: 2),

                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
