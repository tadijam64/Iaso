import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Reminders/ReminderManager.dart';

import '../main.dart';

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
    reminderManager.requestIOSPermissions();
    reminderManager.configureDidReceiveLocalNotificationSubject(context);
    reminderManager.configureSelectNotificationSubject(context);
    return Scaffold(
      body: Container(
        color: Colors.grey[100],
      ),
    );
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  afterBuild(context) {
    Settings().startUp();
  }
}
