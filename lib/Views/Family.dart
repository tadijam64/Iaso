import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Views/Contacts.dart';
import 'package:iaso/Widget/FamilyTile.dart';

class Family extends StatefulWidget {
  FamilyState createState() => new FamilyState();
}

class FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  Color gradientStart = Colors.purple, gradientEnd = Colors.deepPurple;
  List<String> menu = ["My family", "Request"];

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
                  trailing: GestureDetector(
                      onTap: () => {Get.to(Contacts())},
                      child: Icon(
                        CupertinoIcons.add,
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
                          child: _content(),
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

  _content() {
    //1. dohvati kontakte
    //2. dohvati sve requestove
    //3. provjeri match
    //4. Prikaži

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
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Center(
                child: Text(
              "Family requests 0",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.bold),
            )),
          ),
          SizedBox(
            height: 10,
          ),
          FamilyTile(),
          SizedBox(
            height: 10,
          ),
          FamilyTile(),
          SizedBox(
            height: 10,
          ),
          FamilyTile(),
        ],
      ),
    ));
  }
}
