import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/get_started.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/splash.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/sos/emergencyCall.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/video_suggestion/shorts_videos.dart';
import 'presentation/screens/ai_chatbot/chatmodel.dart';
import 'presentation/screens/auth/google_sign_in_provider.dart';
import 'presentation/screens/home/home.dart';
import 'route_names.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.dashboardMain:
        return MaterialPageRoute(builder: (context) => const DashboardMain());
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => Splash());
      case RoutesName.getStarted:
        return MaterialPageRoute(builder: (context) => GetStarted());
      case RoutesName.chatbot:
        return MaterialPageRoute(builder: (context) => const ChatModel());
      case RoutesName.shortVideos:
        return MaterialPageRoute(builder: (context) => ShortVideos());
      case RoutesName.authverifier:
        return MaterialPageRoute(builder: (context) => AuthVerifier());
      case RoutesName.authverifier:
        return MaterialPageRoute(builder: (context) => const EmergencyCall());

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Route Not Found"),
            ),
          ),
        );
    }
  }
}
