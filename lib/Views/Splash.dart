import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/Settings.dart';

class SplashScreen extends StatefulWidget {
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild(context));
    Settings().startUp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
      ),
    );
  }

  afterBuild(context) {
    Settings().startUp();
  }
}
