import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Icons/iaso_icons.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';

import 'Health.dart';

class AddHealthRecord extends StatefulWidget {
  AddHealthRecordState createState() => new AddHealthRecordState();
}

class AddHealthRecordState extends State<AddHealthRecord> {
  HealthCheck healthCheck;
  List<bool> coughButtonStateList = [true, false, false];
  List<bool> headacheStateList = [true, false];
  List<bool> musclePainStateList = [true, false];

  AddHealthRecordState();

  @override
  void initState() {
    super.initState();
    healthCheck = new HealthCheck(
        id: "",
        temperature: 36.5,
        musclePain: false,
        headache: false,
        cough: 0,
        timestamp: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  //Gradient
  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);

  Widget pageScafold() {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: GradientCheatingBorder.fromBorderSide(
              BorderSide.none,
              gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  CupertinoIcons.heart_solid,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Add new Health record",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          child: Scaffold(
            body: SafeArea(
                child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
              ),
              child: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    width: double.infinity,
                    child: _content(),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(70.0))),
                  )),
            )),
          ),
        );
      },
    );
  }

  _content() {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              width: double.infinity,
              height: 30,
              child: Text("Please enter your symptoms",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.cough,
                      color: healthCheck.cough != 0 ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(_getCoughType(healthCheck.cough))),
                    Spacer(),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.insert_emoticon),
                        Icon(Icons.invert_colors_off),
                        Icon(Icons.invert_colors),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < coughButtonStateList.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              coughButtonStateList[buttonIndex] = true;
                              healthCheck.cough = buttonIndex;
                            } else {
                              coughButtonStateList[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: coughButtonStateList,
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.headache,
                      color: healthCheck.headache ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            healthCheck.headache ? "Headache" : "No headache")),
                    Spacer(),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.not_interested),
                        Icon(Icons.check),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < headacheStateList.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              headacheStateList[buttonIndex] = true;
                              healthCheck.headache = buttonIndex == 1;
                            } else {
                              headacheStateList[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: headacheStateList,
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.pain__1_,
                      color: healthCheck.musclePain ? Colors.blue : Colors.grey,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(healthCheck.musclePain
                            ? "Muscle Pain"
                            : "No body ache")),
                    Spacer(),
                    ToggleButtons(
                      children: <Widget>[
                        Icon(Icons.not_interested),
                        Icon(Icons.check),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < musclePainStateList.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              musclePainStateList[buttonIndex] = true;
                              healthCheck.musclePain = buttonIndex == 1;
                            } else {
                              musclePainStateList[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: musclePainStateList,
                    ),
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Iaso.fever,
                      size: 32,
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text("Temperature: " +
                            healthCheck.temperature.toString())),
                    Spacer(),
                    Slider(
                      min: 35.0,
                      max: 42.0,
                      value: healthCheck.temperature,
                      divisions: 14,
                      onChanged: (value) {
                        setState(() {
                          healthCheck.temperature = value;
                        });
                      },
                    ),
                  ],
                )),
            Expanded(child: Material()),
            Center(
                child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
              child: Text(
                'Add record',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                HealthFirebaseManager().addHealthEntry(healthCheck);
                Get.back();
              },
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
