import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';

class Family extends StatefulWidget {
  FamilyState createState() => new FamilyState();
}

class FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  Color gradientStart = Colors.purple, gradientEnd = Colors.deepPurple;

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(),
          onTap: (index) {
            Menu().transfer(context, index);
          },
          currentIndex: 0,
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
                    middle: Text(
                      "Family",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  child: Scaffold(
                    body: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [gradientStart, gradientEnd]),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Container(
                              child: _content(),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(70.0))),
                            )),
                      ),
                    ),
                  ));
            },
          );
        });
  }

  _content() {}
}
