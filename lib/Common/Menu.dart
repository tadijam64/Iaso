import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Views/Family.dart';
import 'package:iaso/Views/Supplies.dart';

class Menu {
  void transfer(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Family()));
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Daily()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Supplies()));
        break;
      case 3:
      default:
        break;
    }
  }

  List<BottomNavigationBarItem> tabBar() {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person,
            size: 24,
          ),
          title: Text("Family")),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.news,
            size: 24,
          ),
          title: Text("Daily report")),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.shopping_cart,
            size: 24,
          ),
          title: Text("Supplies")),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.heart,
            size: 24,
          ),
          title: Text("Health "))
    ];
  }
}
