import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthOverview.dart';
import 'package:iaso/Models/Supplies/SuppliesFirebaseManager.dart';
import 'package:iaso/Models/Supplies/Supply.dart';
import 'package:iaso/Models/User/User.dart';
import 'package:iaso/Views/Health.dart';

class FamilyTile extends StatefulWidget {
  User user;

  FamilyTile({this.user});

  FamilyTileStatus createState() => new FamilyTileStatus(this.user);
}

class FamilyTileStatus extends State<FamilyTile> {
  User user;
  HealthOverview overview = HealthOverview(
      healthScore: 0,
      temperatureAverage: 0.0,
      temperatureStatus: TemperatureStatus.good,
      overallBodyHealth: OverallBodyHealth.excellent);
  List<Supply> supply = List();

  FamilyTileStatus(this.user);

  @override
  void initState() {
    super.initState();
    _prepareUserData(user);
  }

  List<Color> _getStatusColors() {
    switch (overview.overallBodyHealth) {
      case OverallBodyHealth.excellent:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case OverallBodyHealth.veryGood:
        return [Color(0xFF05A66B), Color(0xFF02734A)];
      case OverallBodyHealth.good:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case OverallBodyHealth.ok:
        return [Color(0xFFF2CB05), Color(0xFFF2B705)];
      case OverallBodyHealth.bad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      case OverallBodyHealth.veryBad:
        return [Color(0xFFD92525), Color(0xFF8C0808)];
      default:
        return [Color(0xFFDFF25), Color(0xFF8FF08)];
    }
  }

  void _prepareUserData(User user) {
    HealthFirebaseManager()
        .getAllHealthReportEntries(user.id)
        .listen((onHealthList) {
      HealthOverview healthOverview =
          HealthFirebaseManager().getHealthOverview(user, onHealthList);
      SuppliesFirebaseManager supI = new SuppliesFirebaseManager();
      supI.getBuyList(user.id).listen((supplies) {
        setState(() {
          overview = healthOverview;
          supply = supplies;
        });
      });
    });
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
        height: 110,
        decoration: BoxDecoration(
            color: Color(0xFFF7F7F7),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: CupertinoButton(
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
                              gradient:
                                  LinearGradient(colors: _getStatusColors()),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(60))),
                          child: Center(
                              child: Text(
                            user.name.substring(0, 2).toUpperCase(),
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Roboto'),
                          )),
                        ),
                        user.avatar != null
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage: MemoryImage(user.avatar),
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
                          user.name,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          _getDescription(),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                )),
            onPressed: () {
              Get.to(Health(userId: user.id));
            }));
  }
}
