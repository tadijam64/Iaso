enum TemperatureStatus { bad, good }

enum OverallBodyHealth { bad, ok, good }

class HealthOverview {
  double temperatureAverage;
  TemperatureStatus temperatureStatus;
  OverallBodyHealth overallBodyHealth;

  HealthOverview({this.temperatureAverage, this.temperatureStatus, this.overallBodyHealth});
}
