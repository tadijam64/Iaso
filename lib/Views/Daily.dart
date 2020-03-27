import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velecasni/Common/AppBarGradient.dart';
import 'package:velecasni/Common/Menu.dart';

class Daily extends StatefulWidget {
  DailyState createState() => new DailyState();
}

class DailyState extends State<Daily> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  Color gradientStart = Colors.blue, gradientEnd = Color(0xFF135a91);

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(),
          onTap: (index) {
            Menu().transfer(context, index);
          },
          currentIndex: 1,
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
                      "Daily report",
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
