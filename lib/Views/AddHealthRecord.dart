import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Icons/iaso_icons.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';
import 'package:iaso/Views/Health.dart';

class AddHealthRecord extends StatefulWidget {
  AddHealthRecordState createState() => new AddHealthRecordState();
}

class AddHealthRecordState extends State<AddHealthRecord> {
  HealthCheck healthCheck;
  List<bool> coughButtonStateList = [true, false, false];
  List<bool> headacheStateList = [true, false];
  List<bool> musclePainStateList = [true, false];
  List<bool> soreThroatStateList = [true, false];
  List<bool> shortnessOfBreathList = [true, false];
  List<bool> fatigueList = [true, false];

  AddHealthRecordState();

  @override
  void initState() {
    super.initState();
    healthCheck = new HealthCheck(
        id: "",
        temperature: 36.5,
        musclePain: false,
        headache: false,
        soreThroat: false,
        shortnessOfBreath: false,
        fatigue: false,
        cough: 0,
        timestamp: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  //Gradient
  Color gradientStart = Color(0xFFD92525),
      gradientEnd = Color(0xFF8C0808),
      back = Color(0xFFf3bdbd);

  Widget pageScafold() {
    return CupertinoTabView(
      builder: (BuildContext context) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            border: GradientCheatingBorder.fromBorderSide(
              BorderSide.none,
              gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
            ),
            leading: GestureDetector(
              child: Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Icon(
                    CupertinoIcons.back,
                    size: 28,
                    color: Colors.white,
                  )),
              onTap: () => Get.back(),
            ),
            middle: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "New health record",
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
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Text("Please enter your symptoms",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                _temp(),
                SizedBox(
                  height: 10,
                ),
                _cough(),
                SizedBox(
                  height: 10,
                ),
                _headache(),
                SizedBox(
                  height: 10,
                ),
                _ache(),
                SizedBox(
                  height: 10,
                ),
                _soreThroat(),
                SizedBox(
                  height: 10,
                ),
                _shortnessOfBreath(),
                SizedBox(
                  height: 10,
                ),
                _fatigue(),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: CupertinoButton(
                  child: Text(
                    'Save record',
                    style: TextStyle(fontSize: 20, color: gradientStart),
                  ),
                  onPressed: () {
                    HealthFirebaseManager().addHealthEntry(healthCheck);
                    Get.off(Health());
                  },
                ))
              ],
            )));
  }

  _cough() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.cough,
                    color: healthCheck.cough != 0 ? gradientStart : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(_getCoughType(healthCheck.cough)))
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                height: 35,
                child: ToggleButtons(
                  color: Colors.grey[400],
                  selectedColor: gradientStart,
                  borderColor: gradientStart,
                  selectedBorderColor: gradientStart,
                  fillColor: back,
                  children: <Widget>[
                    Container(
                        width: ((MediaQuery.of(context).size.width * 0.85) / 3),
                        height: 50,
                        child: Icon(Icons.insert_emoticon)),
                    Container(
                        width: ((MediaQuery.of(context).size.width * 0.85) / 3),
                        height: 50,
                        child: Icon(Icons.invert_colors_off)),
                    Container(
                        width: ((MediaQuery.of(context).size.width * 0.85) / 3),
                        height: 50,
                        child: Icon(Icons.invert_colors)),
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
                )),
          ],
        ));
  }

  _headache() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.headache,
                    color: healthCheck.headache ? gradientStart : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                          healthCheck.headache ? "Headache" : "No headache"))
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: ToggleButtons(
                color: Colors.grey[400],
                selectedColor: gradientStart,
                borderColor: gradientStart,
                selectedBorderColor: gradientStart,
                fillColor: back,
                children: <Widget>[
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.not_interested)),
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.check)),
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
            )
          ],
        ));
  }

  _soreThroat() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.sore_throat,
                    color: healthCheck.soreThroat ? gradientStart : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(healthCheck.soreThroat
                          ? "Sore throat"
                          : "No sore throat"))
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: ToggleButtons(
                color: Colors.grey[400],
                selectedColor: gradientStart,
                borderColor: gradientStart,
                selectedBorderColor: gradientStart,
                fillColor: back,
                children: <Widget>[
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.not_interested)),
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.check)),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < soreThroatStateList.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        soreThroatStateList[buttonIndex] = true;
                        healthCheck.soreThroat = buttonIndex == 1;
                      } else {
                        soreThroatStateList[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: soreThroatStateList,
              ),
            )
          ],
        ));
  }

  _shortnessOfBreath() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.sweat,
                    color: healthCheck.shortnessOfBreath
                        ? gradientStart
                        : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(healthCheck.shortnessOfBreath
                          ? "Shortness of breath"
                          : "No shortness of breath"))
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: ToggleButtons(
                color: Colors.grey[400],
                selectedColor: gradientStart,
                borderColor: gradientStart,
                selectedBorderColor: gradientStart,
                fillColor: back,
                children: <Widget>[
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.not_interested)),
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.check)),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < shortnessOfBreathList.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        shortnessOfBreathList[buttonIndex] = true;
                        healthCheck.shortnessOfBreath = buttonIndex == 1;
                      } else {
                        shortnessOfBreathList[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: shortnessOfBreathList,
              ),
            )
          ],
        ));
  }

  _fatigue() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.burnout,
                    color: healthCheck.fatigue ? gradientStart : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child:
                          Text(healthCheck.fatigue ? "Fatigue" : "No fatigue"))
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: ToggleButtons(
                color: Colors.grey[400],
                selectedColor: gradientStart,
                borderColor: gradientStart,
                selectedBorderColor: gradientStart,
                fillColor: back,
                children: <Widget>[
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.not_interested)),
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.check)),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int buttonIndex = 0;
                        buttonIndex < fatigueList.length;
                        buttonIndex++) {
                      if (buttonIndex == index) {
                        fatigueList[buttonIndex] = true;
                        healthCheck.fatigue = buttonIndex == 1;
                      } else {
                        fatigueList[buttonIndex] = false;
                      }
                    }
                  });
                },
                isSelected: fatigueList,
              ),
            )
          ],
        ));
  }

  _temp() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.fever,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text("Temperature: " +
                          healthCheck.temperature.toString())),
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: Slider(
                min: 35.0,
                max: 42.0,
                activeColor: gradientStart,
                divisions: 14,
                inactiveColor: Colors.grey[500],
                value: healthCheck.temperature,
                onChanged: (value) {
                  setState(() {
                    healthCheck.temperature = value;
                  });
                },
              ),
            )
          ],
        ));
  }

  _ache() {
    return Container(
        padding: const EdgeInsets.only(left: 10, top: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: (MediaQuery.of(context).size.width * 0.9),
                child: Row(children: <Widget>[
                  Icon(
                    Iaso.pain,
                    color: healthCheck.musclePain ? gradientStart : Colors.grey,
                    size: 24,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(healthCheck.musclePain
                          ? "Muscle Pain"
                          : "No body ache")),
                ])),
            SizedBox(
              height: 5,
            ),
            Container(
              width: (MediaQuery.of(context).size.width * 0.9),
              height: 35,
              child: ToggleButtons(
                color: Colors.grey[400],
                selectedColor: gradientStart,
                borderColor: gradientStart,
                selectedBorderColor: gradientStart,
                fillColor: back,
                children: <Widget>[
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.not_interested)),
                  Container(
                      width: ((MediaQuery.of(context).size.width * 0.85) / 2),
                      height: 50,
                      child: Icon(Icons.check))
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
            )
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
