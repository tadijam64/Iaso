import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';
import 'package:iaso/Icons/iaso_icons.dart';
import 'package:intl/intl.dart';

class HealthOverviewTile extends StatelessWidget {
  final HealthCheck healthCheck;

  HealthOverviewTile({this.healthCheck});
  Color gradientStart = Color(0xFFD92525);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(5))),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Iaso.headache,
                      color: healthCheck.headache ? gradientStart : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Headache"))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Fatigue")),
                    Icon(
                      Iaso.burnout,
                      color: healthCheck.fatigue ? gradientStart : Colors.grey,
                      size: 30,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Iaso.cough,
                      color:
                          healthCheck.cough != 0 ? gradientStart : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(_getCoughType(healthCheck.cough)))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Shortness of breath")),
                    Icon(
                      Iaso.sweat,
                      color: healthCheck.shortnessOfBreath
                          ? gradientStart
                          : Colors.grey,
                      size: 32,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Iaso.fever,
                      size: 32,
                      color: gradientStart,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Temperature: " +
                            healthCheck.temperature.toString()))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("Sore throat")),
                    Icon(
                      Iaso.sore_throat,
                      color:
                          healthCheck.soreThroat ? gradientStart : Colors.grey,
                      size: 32,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Iaso.pain,
                      color:
                          healthCheck.musclePain ? gradientStart : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text("MusclePain"))
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(DateFormat('yyyy-MM-dd – kk:mm')
                            .format(healthCheck.timestamp))),
                    Icon(
                      CupertinoIcons.time,
                      color: gradientStart,
                      size: 32,
                    ),
                  ],
                )
              ],
            ),
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
