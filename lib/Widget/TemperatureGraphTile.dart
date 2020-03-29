import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iaso/Common/Settings.dart';
import 'package:iaso/Models/Health/GetHealthReportInteractor.dart';
import 'package:iaso/Models/Health/HealthCheck.dart';
import 'package:iaso/Widget/HealthOverviewTile.dart';

class TemperatureGraphTile extends StatefulWidget {
  TemperatureGraphTileState createState() => new TemperatureGraphTileState();
}

class TemperatureGraphTileState extends State<TemperatureGraphTile> {
  HealthFirebaseManager healthManager = HealthFirebaseManager();
  List<HealthCheck> healthChecks = List();
  HealthCheck selectedHealthCheck = new HealthCheck(
      temperature: 0.0,
      musclePain: false,
      headache: false,
      cough: 0,
      timestamp: DateTime.now());

  @override
  void initState() {
    super.initState();
    HealthFirebaseManager()
        .getAllHealthReportEntries(Settings().userId)
        .listen((value) {
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
      child: Column(children: <Widget>[
        Expanded(
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
        )),
        SizedBox(
          height: 20,
        ),
        HealthOverviewTile(healthCheck: selectedHealthCheck)
      ]),
    );
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
