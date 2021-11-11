import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tut/services/auth.dart';
import 'package:firebase_tut/services/db.dart';
import 'package:firebase_tut/services/models.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  OtpScreen(
    this.verificationId, {
    Key key,
  }) : super(key: key);
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: controller,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          print(widget.verificationId);
                          print(controller.text);
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.verificationId,
                            smsCode: controller.text,
                          );
                          await AuthService()
                              .auth
                              .signInWithCredential(credential);
                          User user = AuthService().auth.currentUser;
                          await DatabaseService().writeStudent(
                            Student(
                              name: user.displayName,
                              marks: 100,
                              rollNo: user.email,
                              uid: user.uid,
                              course: user.phoneNumber,
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Correct fields first'),
                            ),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
