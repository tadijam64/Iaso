import 'package:flutter/material.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';

class HealthTile extends StatefulWidget {
  HealthTileState createState() => new HealthTileState();
}

class HealthTileState extends State<HealthTile> {
  OverallBodyHealth status = OverallBodyHealth.good;
  String temperatureAverage = "";
  HealthFirebaseManager healthManager = HealthFirebaseManager();

  List<Color> _getStatusColors() {
    switch (status) {
      case OverallBodyHealth.good:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case OverallBodyHealth.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case OverallBodyHealth.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      default:
        return [Color(0xFFFFF6B), Color(0xFF0F0FF)];
    }
  }

  @override
  void initState() {
    super.initState();
    HealthFirebaseManager().getAllHealthReportEntries(Settings().userId).listen((value) {
      setState(() {
        HealthOverview healthOverview;
        if (value != null) {
          healthOverview = healthManager.getHealthOverview(value.values.toList());
        } else {
          healthOverview = healthManager.getHealthOverview(null);
        }
        temperatureAverage = healthOverview.temperatureAverage.toString() + " °C";
        status = healthOverview.overallBodyHealth;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 150,
                      decoration:
                          BoxDecoration(gradient: LinearGradient(colors: _getStatusColors()), borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                          child: Text(
                        "Your average temperature: " + temperatureAverage,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            )));
  }
}
