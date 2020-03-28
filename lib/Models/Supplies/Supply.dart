enum SupplyStatus{ active, done}

class Supply {
  String name;
  int count;
  int status;

  Supply({this.name, this.count, this.status});

  Supply.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    data['status'] = this.status;
    return data;
  }
}
