class User {
  String id;
  int age;
  String name;
  String phoneNumber;

  User({
    this.id,
    this.age,
    this.name,
    this.phoneNumber,
  });

  User.fromJson(String documentID, Map<String, dynamic> json) {
    id = documentID;
    age = json['age'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
