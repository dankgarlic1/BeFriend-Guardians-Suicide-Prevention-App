import 'package:flutter/material.dart';
// import 'package:guardians_suicide_prevention_app/presentation/screens/auth/auth_loginn.dart';
import 'dart:ui';

import 'package:guardians_suicide_prevention_app/route_names.dart';

import '../../../domain/ads/ads.dart';

class GetStarted extends StatefulWidget {
  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    super.initState();
    Ads().showInterstitialAd();
  }

  @override
  void dispose() {
    super.dispose();
    Ads.rewardedAd!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.003, 1),
            end: Alignment(0.003, -1),
            colors: <Color>[Color(0xff8a1a99), Color(0xff6f1097)],
            stops: <double>[0, 1],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 4 * fem),
                padding: EdgeInsets.fromLTRB(
                    104 * fem, 334 * fem, 111.14 * fem, 0 * fem),
                width: double.infinity,
                height: 546 * fem,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 214 * fem,
                    height: 212 * fem,
                    child: Image.asset(
                      'assets/getStarted.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 258 * fem,
              top: 516 * fem,
              child: Align(
                child: SizedBox(
                  width: 141.42 * fem,
                  height: 141.42 * fem,
                  child: Transform.rotate(
                    angle: 45 * 3.14159265359 / 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.795, 0.767),
                          end: Alignment(0.831, -0.807),
                          colors: <Color>[
                            Color(0xff990099),
                            Color(0xff660066)
                          ], // Darker purple shades
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0 * fem,
              top: 163 * fem,
              child: Align(
                child: SizedBox(
                  width: 141.42 * fem,
                  height: 141.42 * fem,
                  child: Transform.rotate(
                    angle: 45 * 3.14159265359 / 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.522, -0.157),
                          end: Alignment(0.503, 0.143),
                          colors: <Color>[Color(0x438a1a99), Color(0x7f6f1097)],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0 * fem,
              top: 587 * fem,
              child: Align(
                child: SizedBox(
                  width: 255.14 * fem,
                  height: 255.14 * fem,
                  child: Transform.rotate(
                    angle: 135 * 3.14159265359 / 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.516, -0.885),
                          end: Alignment(0.509, 0.865),
                          colors: <Color>[Color(0x438a1a99), Color(0x7f6f1097)],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 150 * fem,
              top: 0 * fem,
              child: Align(
                child: SizedBox(
                  width: 255.14 * fem,
                  height: 255.14 * fem,
                  child: Transform.rotate(
                    angle: 45 * 3.14159265359 / 180,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(0.831, 0.807),
                          end: Alignment(-0.795, -0.767),
                          colors: <Color>[Color(0x8a1a99), Color(0x6f1097)],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 80 * fem,
              top: 591 * fem,
              child: Align(
                child: SizedBox(
                  width: 215 * fem,
                  height: 17 * fem,
                  child: Text(
                    'SPREAD-LOVE-CARE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.20 * ffem / fem,
                      letterSpacing: 1 * fem,
                      color: Colors.white, // White text color
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 106 * fem,
              top: 651 * fem,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 4 * fem,
                    sigmaY: 4 * fem,
                  ),
                  child: Container(
                    width: 162 * fem,
                    height: 52 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30 * fem),
                      gradient: const LinearGradient(
                        begin: Alignment(1, 1),
                        end: Alignment(-1, -1),
                        colors: <Color>[
                          Color(0xffFF00FF), // Start color (purple)
                          Color(0xffce0ece), // End color (purple)
                        ],
                        stops: <double>[0, 1],
                      ),
                    ),
                    child: Center(
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RoutesName.authverifier);
                          },
                          child: Text(
                            'GET STARTED',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.5 * ffem / fem,
                              letterSpacing: 0.6000000238 * fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
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
