import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velecasni/Common/Menu.dart';

class Family extends StatefulWidget {
  FamilyState createState() => new FamilyState();
}

class FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

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
                  middle: Text("Family"),
                ),
                child: Material(),
              );
            },
          );
        });
  }
}
