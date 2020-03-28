import 'package:flutter/material.dart';

class FamilyTile extends StatelessWidget {
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
                          gradient: LinearGradient(
                              colors: [Color(0xFF05A66B), Color(0xFF02734A)]),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Center(
                          child: Text(
                        "LR",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                    ),
                    /*CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.black,
                          )*/
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
                      "Leo Siniša Radošić",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Supplys 9, Health status: OK",
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
