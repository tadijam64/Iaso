import 'dart:typed_data';

import 'package:flutter/material.dart';

enum FamilyStatus { good, ok, bad }

class FamilyTile extends StatelessWidget {
  FamilyStatus status = FamilyStatus.good;
  String name = "";
  String description = "";
  Uint8List avatar;

  FamilyTile({this.status, this.name, this.description, this.avatar});

  List<Color> _getStatusColors() {
    switch (status) {
      case FamilyStatus.good:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
        break;
      case FamilyStatus.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
        break;
      case FamilyStatus.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: _getStatusColors()),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                          child: Text(
                        name.substring(0, 2).toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                    avatar != null
                        ? CircleAvatar(
                            radius: 25,
                            backgroundImage: MemoryImage(avatar),
                          )
                        : Material()
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            )));
  }
}
