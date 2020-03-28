import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/Supplies/Supply.dart';

enum FamilyStatus { good, ok, bad }

class FamilyTile extends StatefulWidget {
  FamilyStatus status = FamilyStatus.good;
  String name = "";
  String description = "";
  Uint8List avatar;
  HealthOverview overview;
  List<Supply> supply;

  FamilyTile(
      {this.status,
      this.name,
      this.description,
      this.avatar,
      this.overview,
      this.supply});
  FamilyTileStatus createState() => new FamilyTileStatus(this.status, this.name,
      this.description, this.avatar, this.overview, this.supply);
}

class FamilyTileStatus extends State<FamilyTile> {
  FamilyStatus status = FamilyStatus.good;
  String name = "";
  String description = "";
  Uint8List avatar;
  HealthOverview overview;
  List<Supply> supply;
  FamilyTileStatus(this.status, this.name, this.description, this.avatar,
      this.overview, this.supply);

  List<Color> _getStatusColors() {
    switch (overview.overallBodyHealth) {
      case OverallBodyHealth.good:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
        break;
      case OverallBodyHealth.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
        break;
      case OverallBodyHealth.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
        break;
    }
  }

  String _getDescription() {
    return "Supplies: " +
        (supply != null ? supply.length.toString() : "0") +
        " ,Avg. temperature " +
        overview.temperatureAverage.toString();
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
                      _getDescription(),
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
