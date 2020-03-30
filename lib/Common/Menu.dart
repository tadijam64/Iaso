import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Views/Daily.dart';
import 'package:iaso/Views/Family.dart';
import 'package:iaso/Views/Health.dart';
import 'package:iaso/Views/Supplies.dart';
import 'package:iaso/Widget/Chat.dart';

import 'Settings.dart';

class Menu {
  Color gradientStart = Color(0xFFD92525);
  void transfer(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => new Family()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => new Daily(
                      iasoDefault: <Widget>[
                        ChatBubble(
                          text:
                              "Hey! I'm Isao, Greek goodess of recuperation from illness. \n\nI'm here to help you with your Covid-19 questions!",
                          right: false,
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                      responesDefault: <String>[
                        "Hey! How are you?",
                        "Today's report?"
                      ],
                    )));
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

  List<BottomNavigationBarItem> tabBar({int selected = 0}) {
    return [
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.person_solid,
            size: 30,
            color: selected == 0 ? gradientStart : Colors.grey,
          ),
          title: Text(
            "Family",
            style: TextStyle(
                fontSize: 12,
                color: selected == 0 ? gradientStart : Colors.grey),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            size: 25,
            color: selected == 1 ? gradientStart : Colors.grey,
          ),
          title: Text(
            "Iaso",
            style: TextStyle(
                fontSize: 12,
                color: selected == 1 ? gradientStart : Colors.grey),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.shopping_cart,
            color: selected == 2 ? gradientStart : Colors.grey,
            size: 30,
          ),
          title: Text(
            "Supplies",
            style: TextStyle(
                fontSize: 12,
                color: selected == 2 ? gradientStart : Colors.grey),
          )),
      BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.heart_solid,
            size: 30,
            color: selected == 3 ? gradientStart : Colors.grey,
          ),
          title: Text(
            "Health",
            style: TextStyle(
                fontSize: 12,
                color: selected == 3 ? gradientStart : Colors.grey),
          ))
    ];
  }
}
