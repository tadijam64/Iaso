import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Views/Family.dart';
import 'package:iaso/Views/Health.dart';
import 'package:rxdart/rxdart.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}

// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();
enum Deeplink { iaso, health }

class ReminderManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void showNotification(String title, String body, [Deeplink deeplink]) async {
    String channel = "iaso";
    if (deeplink == null) {
      channel = "notification";
    } else {
      channel = "deeplink";
    }
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'iaso', channel, 'medicalReminder',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    return await notificationsPlugin.show(
        0, title, body, platformChannelSpecifics,
        payload: deeplink.toString());
  }

  void scheduleNotification(String title, String body, DateTime dateTime,
      [Deeplink deeplink]) async {
    String channel = "iaso";
    if (deeplink == null) {
      channel = "notification";
    } else {
      channel = "deeplink";
    }
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'iaso', channel, 'medicalReminder',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    return await notificationsPlugin.schedule(
        0, title, body, dateTime, platformChannelSpecifics,
        androidAllowWhileIdle: true, payload: deeplink.toString());
  }

  void requestIOSPermissions() {
    notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject(BuildContext context) {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                if (receivedNotification.payload == Deeplink.iaso.toString()) {
                  Get.to(Daily());
                } else {
                  Get.to(Health(userId: Settings().userId));
                }
              },
            )
          ],
        ),
      );
    });
  }

  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((String payload) async {
      if (payload == Deeplink.iaso.toString()) {
        Get.to(Family());
      } else {
        Get.to(Health(userId: Settings().userId));
      }
    });
  }
}
