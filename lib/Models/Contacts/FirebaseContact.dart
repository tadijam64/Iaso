class FirebaseContact {
  bool accepted;
  String phoneNumber;

  FirebaseContact({this.accepted, this.phoneNumber});

  FirebaseContact.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted'] = this.accepted;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
