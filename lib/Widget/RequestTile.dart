import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  String name = "";
  String phoneNumber = "";
  Uint8List avatar;

  List<Color> _getStatusColors() {
    return [Color(0xFF05A66B), Color(0xFF02734A)];
  }

  RequestTile({this.name, this.phoneNumber, this.avatar});

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
                            radius: 30,
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
                  ],
                ),
                Expanded(child: Material()),
                CupertinoButton(
                  onPressed: () => {},
                  child: Text(
                    'Approve',
                    style: TextStyle(color: CupertinoColors.activeGreen),
                  ),
                )
              ],
            )));
  }
}
