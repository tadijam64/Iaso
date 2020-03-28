import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Model/PoolData.dart';

class Pool extends StatefulWidget {
  PoolState createState() => new PoolState();
}

class PoolState extends State<Pool> {
  final Map<int, Widget> odabir = const <int, Widget>{
    0: Text('No'),
    1: Text('Self isolated person'),
    2: Text('Confirmed Covid-19'),
  };

  int odabrani = 0;
  TextEditingController nameController = new TextEditingController(),
      ageController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
                  height: 30,
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
                  height: 30,
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
                  height: 30,
                ),
                Text(
                  "Have you been in contact with a person of questionable status (and what type):",
                  style: TextStyle(fontSize: 18.0, color: Colors.black54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: CupertinoSlidingSegmentedControl(
                        children: odabir,
                        groupValue: odabrani,
                        onValueChanged: (value) {
                          odabrani = value;
                          setState(() {});
                        })),
                Expanded(child: Material()),
                Center(
                    child: CupertinoButton(
                  child: Text(
                    'SAVE DATA',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => _saveData(),
                ))
              ])),
    ));
  }

  _saveData() async {
    String name = nameController.text;
    int age = int.parse(ageController.text);

    PoolData pd = new PoolData();
    await pd.saveData(name, age);

    Settings().startUp();
  }
}
