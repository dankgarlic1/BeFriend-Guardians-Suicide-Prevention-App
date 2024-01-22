import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/sos/emergencyCall.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/video_suggestion/shorts_videos.dart';

import '../ai_chatbot/chatmodel.dart';
import '../video_suggestion/video_suggestion.dart';

class DashboardMain extends StatefulWidget {
  const DashboardMain({super.key});

  @override
  State<DashboardMain> createState() => _DashboardMainState();
}

class _DashboardMainState extends State<DashboardMain> {
  int _currentIndex = 0;
  List<Widget> _bottomNavbarScreens = [
    HelpAndSupport(),
    ShortVideos(),
    ChatModel(),
    EmergencyCall(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // drawer: const AppDrawer(),
          // appBar: AppBar(actions: [
          //   IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          //   IconButton(
          //       onPressed: () {}, icon: const Icon(Icons.mail_outline_rounded)),
          //   IconButton(
          //       onPressed: () {},
          //       icon: const Icon(Icons.notifications_none_rounded)),
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.apps_rounded))
          // ]),
          body: _bottomNavbarScreens[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              // selectedLabelStyle
              // unselectedLabelStyle: ,

              selectedItemColor: Colors.deepPurple,
              unselectedItemColor: Colors.grey,
              // selectedIconTheme: const IconThemeData(color: Colors.purple),
              // unselectedIconTheme: const IconThemeData(color: Colors.grey),
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                //changed icons
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 20,
                    ),
                    label: "Videos"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/shorts.png'),
                      size: 17,
                    ),
                    label: "Shorts"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/chatbot.png'),
                      size: 20,
                    ),
                    label: "ChatBot"),
                BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/emergency-call.png'),
                      size: 20,
                    ),
                    label: "Help"),
              ])
          // ElevatedButton(
          // currentIndex: _currentIndex,
          // onTap: (index) {
          //   setState(() {
          //     _currentIndex = index;
          //   });
          // },
          ),
    );
  }
}
