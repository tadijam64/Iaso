import 'package:cloud_firestore/cloud_firestore.dart';

class HealthCheck {
  String id;
  double temperature;
  bool musclePain;
  bool headache;
  bool shortnessOfBreath;
  bool soreThroat;
  bool fatigue;
  bool chills;
  int cough;
  DateTime timestamp;

  HealthCheck(
      {this.id,
      this.temperature,
      this.musclePain,
      this.headache,
      this.fatigue,
      this.shortnessOfBreath,
      this.soreThroat,
      //this.chills,
      this.cough,
      this.timestamp});

  HealthCheck.fromJson(String healthCheckID, Map<String, dynamic> json) {
    id = healthCheckID;
    temperature = json['temperature'].toDouble();
    musclePain = json['musclePain'];
    headache = json['headache'];
    fatigue = json['fatigue'];
    shortnessOfBreath = json['shortnessOfBreath'];
    soreThroat = json['soreThroat'];
    chills = json['chills'];
    cough = json['cough'];
    timestamp = DateTime.fromMillisecondsSinceEpoch(
        json['timestamp'].millisecondsSinceEpoch);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temperature'] = this.temperature;
    data['musclePain'] = this.musclePain;
    data['headache'] = this.headache;
    data['fatigue'] = this.fatigue;
    data['shortnessOfBreath'] = this.shortnessOfBreath;
    data['soreThroat'] = this.soreThroat;
    data['chills'] = this.chills;
    data['cough'] = this.cough;
    data['timestamp'] = Timestamp.fromDate(this.timestamp);
    return data;
  }
}
