import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/screens/OtpScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuth =
        await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await auth.signInWithCredential(credential);
  }

  Future signInWithPhone(String phoneNumber, context) async {
    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(),
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.code),
          ),
        );
      },
      codeSent: (String verificationId, int resendToken) async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId){},
    );
  }
}
