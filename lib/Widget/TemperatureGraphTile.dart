import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';
import 'package:iaso/Views/AddHealthRecord.dart';
import 'package:iaso/Widget/HealthOverviewTile.dart';

class TemperatureGraphTile extends StatefulWidget {
  final String userID;

  TemperatureGraphTile({this.userID});

  TemperatureGraphTileState createState() =>
      new TemperatureGraphTileState(userID: userID);
}

class TemperatureGraphTileState extends State<TemperatureGraphTile> {
  final String userID;

  TemperatureGraphTileState({this.userID});

  HealthFirebaseManager healthManager = HealthFirebaseManager();
  List<HealthCheck> healthChecks = List();
  HealthCheck selectedHealthCheck = new HealthCheck(
      temperature: 0.0,
      musclePain: false,
      headache: false,
      fatigue: false,
      shortnessOfBreath: false,
      soreThroat: false,
      cough: 0,
      timestamp: DateTime.now());

  @override
  void initState() {
    super.initState();
    HealthFirebaseManager().getAllHealthReportEntries(userID).listen((value) {
      setState(() {
        healthChecks = value;
        healthChecks.sort((item1, item2) {
          if (item1.timestamp.isAfter(item2.timestamp)) {
            return 0;
          } else {
            return 1;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: TimeSeriesChart(
                    mapChartData(healthChecks),
                    animate: true,
                    primaryMeasureAxis: NumericAxisSpec(
                        tickProviderSpec: new BasicNumericTickProviderSpec(
                            zeroBound: false, desiredTickCount: 5)),
                    behaviors: [new PanAndZoomBehavior()],
                    selectionModels: [
                      new SelectionModelConfig(
                        type: SelectionModelType.info,
                        changedListener: _onSelectionChanged,
                      )
                    ],
                  ))),
          SizedBox(
            height: 20,
          ),
          HealthOverviewTile(healthCheck: selectedHealthCheck),
          SizedBox(
            height: 20,
          ),
          userID == Settings().userId
              ? GestureDetector(
                  onTap: () => {Get.to(AddHealthRecord())},
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: mat.Color(0xFFD92525),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.create, color: Colors.white, size: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "START NEW CHECK",
                          style:
                              mat.TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ))
              : mat.Material(),
        ]));
  }

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  List<Series<HealthCheck, DateTime>> mapChartData(List<HealthCheck> entries) {
    return [
      Series(
          id: "Body temperature",
          data: entries,
          domainFn: (HealthCheck entry, _) => entry.timestamp,
          measureFn: (HealthCheck entry, _) => entry.temperature)
    ];
  }

  _onSelectionChanged(SelectionModel model) {
    if (model.hasDatumSelection) {
      // Request a build.
      setState(() {
        selectedHealthCheck = model.selectedDatum[0].datum;
      });
    }
  }
}
