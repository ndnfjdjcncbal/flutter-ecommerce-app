class cardmodel {
  String? id;
  String? brand;
  String? last4;
  String? fingerprint;

  cardmodel({this.id, this.brand, this.last4, this.fingerprint});

  cardmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand'];
    last4 = json['last4'];
    fingerprint = json['fingerprint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['last4'] = this.last4;
    data['fingerprint'] = this.fingerprint;
    return data;
  }
}
