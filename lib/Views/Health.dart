import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Widget/HealthOverviewTile.dart';

class Health extends StatefulWidget {
  HealthState createState() => new HealthState();
}

class HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  @override
  void initState() {
    super.initState();
  }

  Color gradientStart = Colors.green, gradientEnd = Colors.lightGreen;

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(),
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
                    gradient: LinearGradient(colors: [gradientStart, gradientEnd]),
                  ),
                  middle: Text(
                    "Health",
                    style: TextStyle(color: Colors.white),
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
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(70.0))),
                        )),
                  )),
                ),
              );
            },
          );
        });
  }

  _content() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(child: HealthTile()),
          ),
        ],
      ),
    ));
  }
}
