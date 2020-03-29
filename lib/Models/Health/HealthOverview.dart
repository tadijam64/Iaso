enum TemperatureStatus { bad, ok, good }

enum OverallBodyHealth { veryBad, bad, ok, good, veryGood, excellent }

class HealthOverview {
  double temperatureAverage;
  TemperatureStatus temperatureStatus;
  OverallBodyHealth overallBodyHealth;
  int healthScore;

  HealthOverview(
      {this.healthScore,
      this.temperatureAverage,
      this.temperatureStatus,
      this.overallBodyHealth});
}
