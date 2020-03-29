import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Views/Family.dart';
import 'package:iaso/Views/Health.dart';
import 'package:iaso/Views/Supplies.dart';

import 'Settings.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Health(userId: Settings().userId)));
        break;
      default:
        break;
    }
  }

  List<BottomNavigationBarItem> tabBar() {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person,
            size: 30,
          ),
          title: Text(
            "Family",
            style: TextStyle(fontSize: 12),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.news,
            size: 30,
          ),
          title: Text(
            "Daily report",
            style: TextStyle(fontSize: 12),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.shopping_cart,
            size: 30,
          ),
          title: Text(
            "Supplies",
            style: TextStyle(fontSize: 12),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.heart,
            size: 30,
          ),
          title: Text(
            "Health",
            style: TextStyle(fontSize: 12),
          ))
    ];
  }
}
