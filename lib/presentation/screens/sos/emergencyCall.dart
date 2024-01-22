import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/ads/ads.dart';

class EmergencyCall extends StatefulWidget {
  const EmergencyCall({super.key});

  @override
  State<EmergencyCall> createState() => _EmergencyCallState();
}

class _EmergencyCallState extends State<EmergencyCall> {
  @override
  void initState() {
    super.initState();
    Ads().showInterstitialAd();
  }

  // Function to make the emergency call
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

  @override
  void dispose() {
    super.dispose();
    Ads.rewardedAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                await Ads().showInterstitialAd();
                makeEmergencyCall();
              },
              child: Container(
                width: 150, // Adjust the size as needed
                height: 150, // Adjust the size as needed
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Emergency Call',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Press this button to call the suicide helpline',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
