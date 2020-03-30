import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/PoolInteractor.dart';
import 'package:iaso/Models/User/User.dart';

class Pool extends StatefulWidget {
  PoolState createState() => new PoolState();
}

class PoolState extends State<Pool> {
  final Map<int, Widget> odabir = const <int, Widget>{
    0: Text('No'),
    1: Text('Yes')
  };

  int selectHypertension = 0;
  int selectCancer = 0;
  int selectCardiovascularIssues = 0;
  int selectChronicRespiratoryDisease = 0;
  int selectDiabetes = 0;

  TextEditingController nameController = new TextEditingController(),
      ageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child: Text(
                  "Your profile",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Name:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(controller: nameController),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Age:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                CupertinoTextField(
                  controller: ageController,
                  keyboardType: TextInputType.numberWithOptions(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you suffer from hypertension?:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: selectHypertension,
                        onValueChanged: (value) {
                          selectHypertension = value;
                          setState(() {});
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you suffer from any long term cardio vascular issues?:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: selectCardiovascularIssues,
                        onValueChanged: (value) {
                          selectCardiovascularIssues = value;
                          setState(() {});
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you have any chronic respiratory disease:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: selectChronicRespiratoryDisease,
                        onValueChanged: (value) {
                          selectChronicRespiratoryDisease = value;
                          setState(() {});
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you suffer from diabetes:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: selectDiabetes,
                        onValueChanged: (value) {
                          selectDiabetes = value;
                          setState(() {});
                        })),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Do you suffer from cancer:",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: selectCancer,
                        onValueChanged: (value) {
                          selectCancer = value;
                          setState(() {});
                        })),
                Center(
                    child: CupertinoButton(
                  child: Text(
                    'SAVE DATA',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => _saveData(),
                    ))
              ])),
    )));
  }

  _saveData() async {
    String name = nameController.text;
    int age = int.parse(ageController.text);

    User user = new User();
    user.age = age;
    user.name = name;
    user.hypertension = selectHypertension == 1 ? true : false;
    user.cardiovascularIssues = selectCardiovascularIssues == 1 ? true : false;
    user.chronicRespiratoryDisease =
        selectChronicRespiratoryDisease == 1 ? true : false;
    user.cancer = selectCancer == 1 ? true : false;
    user.diabetes = selectDiabetes == 1 ? true : false;

    PoolInteractor pd = new PoolInteractor();
    await pd.saveData(user);

    Settings().startUp();
  }
}
