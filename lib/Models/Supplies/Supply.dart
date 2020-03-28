enum SupplyStatus { ok, toBuy, bought }
enum SupplyType { medicine, household }

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

  setStatus(SupplyStatus status) {
    switch (status) {
      case SupplyStatus.ok:
        this.status = 0;
        break;
      case SupplyStatus.toBuy:
        this.status = 1;
        break;
      case SupplyStatus.bought:
        this.status = 2;
        break;
    }
  }

  setType(SupplyType type) {
    switch (type) {
      case SupplyType.medicine:
        this.type = 0;
        break;
      case SupplyType.household:
        this.type = 1;
        break;
    }
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
