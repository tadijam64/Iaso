import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Icons/iaso_icons.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';
import 'package:intl/intl.dart';

class HealthOverviewTile extends StatelessWidget {
  final HealthCheck healthCheck;

  HealthOverviewTile({this.healthCheck});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.headache,
                      color: healthCheck.headache ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Headache"))
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.cough,
                      color: healthCheck.cough != 0 ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(_getCoughType(healthCheck.cough)))
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.fever,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Temperature: " +
                            healthCheck.temperature.toString()))
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.pain__1_,
                      color: healthCheck.musclePain ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("MusclePain"))
                  ],
                )),
            Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      color: Colors.blue,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(DateFormat('yyyy-MM-dd – kk:mm')
                            .format(healthCheck.timestamp)))
                  ],
                ))
          ],
        ));
  }

  String _getCoughType(int cough) {
    switch (cough) {
      case 1:
        return "Dry cough";
      case 2:
        return "Productive cough";
      default:
        return "No cough";
    }
  }
}
