import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Models/User/GetUserInteractor.dart';
import 'package:iaso/Widget/TemperatureGraphTile.dart';
import 'package:iaso/Widget/HealthStatusTile.dart';

import 'AddHealthRecord.dart';

class Health extends StatefulWidget {
  final String userId;

  Health({this.userId});

  HealthState createState() => new HealthState(userId: userId);
}

class HealthState extends State<Health> {
  final String userId;

  HealthState({this.userId});

  String userName = "";

  @override
  void initState() {
    super.initState();
    GetUserInteractor().getUserById(userId).then((user) {
      setState(() {
        userName = user.name + " - ";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  //Gradient
  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(selected: 3),
          onTap: (index) {
            Menu().transfer(context, index);
          },
          currentIndex: 3,
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  border: GradientCheatingBorder.fromBorderSide(
                    BorderSide.none,
                    gradient:
                        LinearGradient(colors: [gradientStart, gradientEnd]),
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
                        userName + "Health",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  trailing: GestureDetector(
                      onTap: () => {Get.to(AddHealthRecord())},
                      child: Icon(
                        Icons.create,
                        color: Colors.white,
                      )),
                ),
                child: Scaffold(
                  body: SafeArea(
                      child: Container(
                    decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [gradientStart, gradientEnd]),
                    ),
                    child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Container(
                          width: double.infinity,
                          child: _content(userId),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(70.0))),
                        )),
                  )),
                ),
              );
            },
          );
        });
  }

  _content(String userID) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(child: TemperatureOverviewTile(userID: userID)),
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(child: TemperatureGraphTile(userID: userID)),
          )
        ],
      ),
    ));
  }
}
