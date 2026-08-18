class latetestaddres {
  String? addresId;
  String? addresUser;
  String? addresCity;
  String? addresStreet;
  String? addresLat;
  String? addresLong;
  String? addresCountry;
  String? addresDatetime;

  latetestaddres({
    this.addresId,
    this.addresUser,
    this.addresCity,
    this.addresStreet,
    this.addresLat,
    this.addresLong,
    this.addresCountry,
    this.addresDatetime,
  });

  latetestaddres.fromJson(Map<String, dynamic> json) {
    addresId = json['addres_id'];
    addresUser = json['addres_user'];
    addresCity = json['addres_city'];
    addresStreet = json['addres_street'];
    addresLat = json['addres_lat'];
    addresLong = json['addres_long'];
    addresCountry = json['addres_country'];
    addresDatetime = json['addres_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addres_id'] = this.addresId;
    data['addres_user'] = this.addresUser;
    data['addres_city'] = this.addresCity;
    data['addres_street'] = this.addresStreet;
    data['addres_lat'] = this.addresLat;
    data['addres_long'] = this.addresLong;
    data['addres_country'] = this.addresCountry;
    data['addres_datetime'] = this.addresDatetime;
    return data;
  }
}
