enum SupplyStatus { active, done }
enum SupplyType { medicine, food, household }

class Supply {
  String name;
  int amount;
  int status;
  int type;

  Supply({this.name, this.amount, this.status, this.type});

  Supply.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    amount = json['amount'];
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['type'] = this.type;
    return data;
  }
}
