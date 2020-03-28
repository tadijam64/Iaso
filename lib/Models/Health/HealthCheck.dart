class HealthCheck {
  double temperature;
  bool musclePain;
  bool headache;
  int cough;
  DateTime timestamp;

  HealthCheck(
      {this.temperature,
      this.musclePain,
      this.headache,
      this.cough,
      this.timestamp});

  HealthCheck.fromJson(Map<String, dynamic> json) {
    temperature = json['temperature'];
    musclePain = json['musclePain'];
    headache = json['headache'];
    cough = json['cough'];
    //timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp'].millisecondsSinceEpoch);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['musclePain'] = this.musclePain;
    data['headache'] = this.headache;
    data['cough'] = this.cough;
    data['timestamp'] = this.timestamp.millisecondsSinceEpoch;
    return data;
  }
}
