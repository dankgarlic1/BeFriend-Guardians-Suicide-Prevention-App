import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/app_guide/get_started.dart';

import '../../../domain/ads/ads.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Ads().createRewardedAd();
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "BE Friend.",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              // CircularProgressIndicator(
              //   color: Colors.white,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
