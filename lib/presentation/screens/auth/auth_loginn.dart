import 'package:flutter/material.dart';
import 'package:guardians_suicide_prevention_app/presentation/screens/home/home.dart';
// import 'package:guardians_suicide_prevention_app/presentation/screens/auth/auth_otp.dart';
import 'package:provider/provider.dart';

// import '../home/home.dart';
import '../../../route_names.dart';
import 'google_sign_in_provider.dart';

class AuthLOGIN extends StatefulWidget {
  const AuthLOGIN({super.key});

  @override
  State<AuthLOGIN> createState() => _AuthLOGINState();
}

class _AuthLOGINState extends State<AuthLOGIN> {
  TextEditingController country_code = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String phoneNumber = '';
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    country_code.text = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/auth/login.png',
                height: 190,
                width: 190,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Lets register safely before getting started!',
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(5),
              //     border: Border.all(
              //       width: 1,
              //       color: Colors.grey.shade400,
              //     ),
              //   ),
              //   child: Row(
              //     children: [
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       SizedBox(
              //         width: 40,
              //         child: TextField(
              //           controller: country_code,
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         width: 5,
              //       ),
              //       const Text(
              //         '|',
              //         style: TextStyle(fontSize: 35, color: Colors.grey),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Expanded(
              //         child: TextField(
              //           controller: phoneNumberController,
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //             hintText: 'Phone Number',
              //           ),
              //           onChanged: (value) {
              //             // Removing any non-digit characters from text
              //             phoneNumber = value.replaceAll(RegExp(r'[^\d]'), '');
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              _isLoading == true
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox(),
              // SizedBox(
              //   height: 50,
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => const AuthOTP())),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.deepPurple,
              //     ),
              //     child: const Text(
              //       "Send One Time Password",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
              // google sign in button
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  child: const Text("Sign In with Google")),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RoutesName.dashboardMain);
                  },
                  child: const Text('Sign In as Guest'))
            ],
          ),
        ),
      ),
    );
  }
}
