import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';
import 'package:iaso/Widget/BuyTile.dart';
import 'package:iaso/Widget/SupplyAddNew.dart';
import 'package:iaso/Widget/SupplyTile.dart';

class Supplies extends StatefulWidget {
  SuppliesState createState() => new SuppliesState();
}

class SuppliesState extends State<Supplies> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);
  List<String> menu = ["Current stock", "Buy list", "Add new"];
  int selectedIndex = 0;

  Widget pageScafold() {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: Menu().tabBar(selected: 2),
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
                    middle: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.shopping_cart,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Supplies",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  child: Scaffold(
                    body: SafeArea(
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [gradientStart, gradientEnd]),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: double.infinity,
                                height: 30,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: menu.length,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                          padding: EdgeInsets.only(left: 35),
                                          child: GestureDetector(
                                              onTap: () => selectMenu(index),
                                              child: Text(
                                                menu[index],
                                                style: TextStyle(
                                                    color:
                                                        selectedIndex == index
                                                            ? Colors.grey[100]
                                                            : Colors.grey[400],
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 1.5),
                                              )));
                                    }),
                              ),
                              Expanded(
                                child: Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      child: _getContent(),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(70.0))),
                                    )),
                              )
                            ],
                          )),
                    ),
                  ));
            },
          );
        });
  }

  _getContent() {
    switch (selectedIndex) {
      case 0:
        return _showSupplies();
        break;
      case 1:
        return _showBuyList();
        break;
      case 2:
        return SupplyAddNew();
        break;
    }
  }

  Stream<List<Supply>> supplies;

  _showSupplies() {
    supplies = SuppliesFirebaseManager().getAllSupplies(Settings().userId);

    return Column(children: <Widget>[
      SizedBox(
        height: 35,
        width: double.infinity,
      ),
      Expanded(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                  child: Column(children: <Widget>[
                    StreamBuilder<List<Supply>>(
                      stream: supplies,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Supply>> supplies) {
                        if (supplies.hasError)
                          return new Text('Error: ${supplies.error}');
                        switch (supplies.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return new Column(
                              children: supplies.data.map((Supply supply) {
                                TextEditingController controller =
                                    new TextEditingController();
                                controller.text = supply.amount.toString();
                                return Column(
                                  children: <Widget>[
                                    SupplyTile(
                                      suply: supply,
                                      controller: controller,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              }).toList(),
                            );
                        }
                      },
                    )
                  ]))))
    ]);

    /**/
  }

  selectMenu(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  _showBuyList() {
    supplies = null;

    return Column(children: <Widget>[
      SizedBox(
        height: 15,
      ),
      Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: CupertinoButton(
            child: Text("Restock selected"), onPressed: () => _reStock()),
      ),
      Expanded(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                  child: Column(children: <Widget>[
                    StreamBuilder<List<Supply>>(
                      stream: SuppliesFirebaseManager()
                          .getBuyList(Settings().userId),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Supply>> supplies) {
                        if (supplies.hasError)
                          return new Text('Error: ${supplies.error}');
                        switch (supplies.connectionState) {
                          case ConnectionState.waiting:
                            return new Text('Loading...');
                          default:
                            return new Column(
                              children: supplies.data.map((Supply supply) {
                                TextEditingController controller =
                                    new TextEditingController();
                                controller.text = supply.amount.toString();
                                return Column(
                                  children: <Widget>[
                                    BuyTile(
                                      suply: supply,
                                      controller: controller,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              }).toList(),
                            );
                        }
                      },
                    )
                  ]))))
    ]);
  }

  StreamSubscription sub;
  _reStock() {
    sub =
        SuppliesFirebaseManager().getBuyList(Settings().userId).listen((data) {
      data.forEach((f) {
        if (f.status == 2) {
          f.amount += f.defaultAmount;
          f.setStatus(SupplyStatus.ok);
          SuppliesFirebaseManager().updateSupply(f.id, f);
        }
      });

      sub.cancel();
    });
  }
}
