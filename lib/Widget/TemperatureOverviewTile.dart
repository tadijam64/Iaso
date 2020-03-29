import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/User/GetUserInteractor.dart';

class TemperatureOverviewTile extends StatefulWidget {
  final String userID;

  TemperatureOverviewTile({this.userID});

  TemperatureOverviewTileState createState() =>
      new TemperatureOverviewTileState(userID: userID);
}

class TemperatureOverviewTileState extends State<TemperatureOverviewTile> {
  final String userID;

  TemperatureOverviewTileState({this.userID});

  TemperatureStatus status = TemperatureStatus.good;
  String temperatureAverage = "";
  HealthFirebaseManager healthManager = HealthFirebaseManager();

  List<Color> _getStatusColors() {
    switch (status) {
      case TemperatureStatus.good:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case TemperatureStatus.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case TemperatureStatus.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      default:
        return [Color(0xFFFFF6B), Color(0xFF0F0FF)];
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
          temperatureAverage =
              healthOverview.temperatureAverage.toStringAsPrecision(4) + " °C";
          status = healthOverview.temperatureStatus;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      width: 320,
                      height: 150,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: _getStatusColors()),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        "Your score: " + temperatureAverage,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                )
              ],
            )));
  }
}
