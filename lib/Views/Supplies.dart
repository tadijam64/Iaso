import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

class Supplies extends StatefulWidget {
  SuppliesState createState() => new SuppliesState();
}

class SuppliesState extends State<Supplies> {
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
          currentIndex: 2,
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
                      "Supplies",
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

  _content() {
    return StreamBuilder<Map<String, Supply>>(
      stream: SuppliesFirebaseManager().getAllSupplies(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, Supply>> supplies) {
        if (supplies.hasError) return new Text('Error: ${supplies.error}');
        switch (supplies.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return new ListView(
              children: supplies.data.values.toList().map((Supply supply) {
                return new ListTile(
                  title: new Text(supply.toJson().toString()),
                );
              }).toList(),
            );
        }
      },
    );
  }
}
