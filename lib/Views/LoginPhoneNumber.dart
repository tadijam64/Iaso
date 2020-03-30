import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/CheckPhoneNumberInteractor.dart';

class LoginPhoneNumber extends StatefulWidget {
  LoginPhoneNumberState createState() => new LoginPhoneNumberState();
}

class LoginPhoneNumberState extends State<LoginPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  Color gradientStart = Colors.orange, gradientEnd = Colors.deepOrange;
  final phoneNumberTextEditControler = TextEditingController();

  Widget pageScafold() {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text(
                  "Your profile",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Please enter your phone number:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 40,
                    child: CupertinoTextField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.phone,
                        controller: phoneNumberTextEditControler)),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Example: +385951234567",
                  style: TextStyle(fontSize: 13.0, color: Colors.black),
                ),
                Expanded(child: Material()),
                Center(
                    child: CupertinoButton(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    CheckPhoneNumberInteractor()
                        .checkPhoneNumber(phoneNumberTextEditControler.text);
                  },
                ))
              ])),
    ));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberTextEditControler.dispose();
    super.dispose();
  }
}
