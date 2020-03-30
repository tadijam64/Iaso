import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/Reminders/ReminderManager.dart';
import 'package:iaso/Models/User/GetUserInteractor.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Widget/Chat.dart';

class TemperatureOverviewTile extends StatefulWidget {
  final String userID;

  TemperatureOverviewTile({this.userID});

  TemperatureOverviewTileState createState() =>
      new TemperatureOverviewTileState(userID: userID);
}

class TemperatureOverviewTileState extends State<TemperatureOverviewTile> {
  final String userID;

  OverallBodyHealth bodyHealth;

  TemperatureOverviewTileState({this.userID});

  String currentHealthStatus = "Your current health status: -";
  HealthFirebaseManager healthManager = HealthFirebaseManager();

  List<Color> _getStatusColors() {
    switch (bodyHealth) {
      case OverallBodyHealth.excellent:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case OverallBodyHealth.veryGood:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case OverallBodyHealth.good:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case OverallBodyHealth.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case OverallBodyHealth.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      case OverallBodyHealth.veryBad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      default:
        return [Color(0xFFDFF25), Color(0xFF8FF08)];
    }
  }

  void _setBodyHealthMessage(OverallBodyHealth overallBodyHealth) {
    currentHealthStatus = "Health status ";
    switch (overallBodyHealth) {
      case OverallBodyHealth.veryBad:
        currentHealthStatus += " Dangerous";
        break;
      case OverallBodyHealth.bad:
        currentHealthStatus += " Bad";
        break;
      case OverallBodyHealth.ok:
        currentHealthStatus += " OK";
        break;
      case OverallBodyHealth.good:
        currentHealthStatus += " Good";
        break;
      case OverallBodyHealth.veryGood:
        currentHealthStatus += " Very Good";
        break;
      case OverallBodyHealth.excellent:
        currentHealthStatus += " Excellent";
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    GetUserInteractor userStream = new GetUserInteractor();
    userStream.getUserById(userID).then((currentUser) {
      HealthFirebaseManager().getAllHealthReportEntries(userID).listen((value) {
        setState(() {
          HealthOverview healthOverview;
          if (value != null) {
            healthOverview =
                healthManager.getHealthOverview(currentUser, value);
          } else {
            healthOverview = healthManager.getHealthOverview(currentUser, null);
          }
          setState(() {
            if (bodyHealth != null &&
                    bodyHealth != healthOverview.overallBodyHealth &&
                    healthOverview.overallBodyHealth == OverallBodyHealth.bad ||
                healthOverview.overallBodyHealth == OverallBodyHealth.veryBad) {
              Get.off(Daily(
                iasoDefault: <Widget>[
                  ChatBubble(
                    right: false,
                    text:
                        "Your health seems deteriorating. \n\n I would advise you to check up with your doctor!",
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
                responesDefault: <String>["Who can i call"],
              ));
            }
            bodyHealth = healthOverview.overallBodyHealth;
            _setBodyHealthMessage(healthOverview.overallBodyHealth);
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: _getStatusColors()),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Center(
                child: Text(
              currentHealthStatus,
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ));
  }
}
