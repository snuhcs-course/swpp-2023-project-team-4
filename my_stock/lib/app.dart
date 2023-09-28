import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              FirebaseAuth _auth = FirebaseAuth.instance;
              await _auth.verifyPhoneNumber(
                phoneNumber: "+821000000000",
                verificationCompleted: (PhoneAuthCredential credential) {
                  print("인증 문자 수신");
                },
                verificationFailed: (FirebaseAuthException e) {
                  throw e;
                },
                codeSent: (String verificationId, int? resendToken) async {},
                codeAutoRetrievalTimeout: (String verificationId) {},
              );
            },
            child: Text("010-0000-0000"),
          ),
        ),
      ),
    );
  }
}
