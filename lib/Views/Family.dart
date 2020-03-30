import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/AppBarGradient.dart';
import 'package:iaso/Common/Menu.dart';
import 'package:iaso/Models/Contacts/ContactInteractor.dart';
import 'package:iaso/Models/Contacts/FirebaseContact.dart';
import 'package:iaso/Models/User/GetUserInteractor.dart';
import 'package:iaso/Models/User/User.dart';
import 'package:iaso/Views/Contacts.dart';
import 'package:iaso/Widget/FamilyTile.dart';
import 'package:iaso/Widget/RequestTile.dart';

class Family extends StatefulWidget {
  FamilyState createState() => new FamilyState();
}

class FamilyState extends State<Family> {
  List<FirebaseContact> requests = new List();
  List<User> familyUsers = new List();
  ContactInteractor contactsInteractor = new ContactInteractor();
  GetUserInteractor getUserInteractor = new GetUserInteractor();

  @override
  Widget build(BuildContext context) {
    return pageScafold();
  }

  @override
  void initState() {
    super.initState();
    contactsInteractor.getMyRequests().listen((value) {
      setState(() {
        requests = value;
        _dohvatiListuRequestova();
      });
    });
    // Get all accepted contacts and show them
    contactsInteractor.getContacts(true).map((contacts) async {
      List<User> family = new List();

      for (var value in contacts) {
        User user =
            await getUserInteractor.getUserByPhoneNumber(value.phoneNumber);

        Iterable<Contact> contacts =
            await ContactsService.getContactsForPhone(value.phoneNumber);

        if (user == null) user = new User();

        if (contacts.length > 0) {
          user.name = contacts.first.displayName;
          if (contacts.first.avatar != null && contacts.first.avatar.length > 0)
            user.avatar = contacts.first.avatar;
        }
        family.add(user);
      }
      return family;
    }).listen((onData) {
      onData.then((onFamilyList) {
        setState(() {
          familyUsers = onFamilyList;
        });
      });
    });
  }

  //Gradient
  Color gradientStart = Color(0xFFD92525), gradientEnd = Color(0xFF8C0808);

  //Color gradientStart = Colors.purple, gradientEnd = Colors.deepPurple;

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
                  middle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(CupertinoIcons.person_solid,
                          color: Colors.white, size: 30),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Family",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
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
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () => otvoriBox(),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Column(children: requestTile))),
          new Column(
              children: familyUsers.map((user) {
            return Column(children: <Widget>[
              SizedBox(
                height: 10,
              ),
              FamilyTile(user: user)
            ]);
          }).toList())
        ],
      ),
    ));
  }

  List<Widget> requestTile = new List();
  bool otvoriRequestove = false;

  _dohvatiListuRequestova() {
    requestTile = new List();
    requestTile.add(SizedBox(
      height: 18,
    ));
    requestTile.add(Center(
        child: Text(
      "Family requests " + requests.length.toString(),
      style: TextStyle(
          fontSize: 14,
          color: requests.length > 0 ? Colors.redAccent : Colors.grey[400],
          fontWeight: FontWeight.bold),
    )));
    requestTile.add(SizedBox(
      height: 18,
    ));

    if (otvoriRequestove) {
      requests.forEach((f) {
        ContactsService.getContactsForPhone(f.phoneNumber).then((val) {
          if (val != null) {
            setState(() {
              requestTile.add(Column(children: <Widget>[
                RequestTile(
                  name: val.first.displayName,
                  phoneNumber: f.phoneNumber,
                  avatar:
                      val.first.avatar != null && val.first.avatar.length > 0
                          ? val.first.avatar
                          : null,
                ),
                SizedBox(
                  height: 10,
                ),
              ]));
            });
          }
        });
      });
    }
  }

  otvoriBox() {
    setState(() {
      otvoriRequestove = !otvoriRequestove;
      _dohvatiListuRequestova();
    });
  }
}
