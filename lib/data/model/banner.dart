class databanner {
  String? banerId;
  String? banerName;
  String? banerText;

  databanner({this.banerId, this.banerName, this.banerText});

  databanner.fromJson(Map<String, dynamic> json) {
    banerId = json['baner_id'];
    banerName = json['baner_name'];
    banerText = json['baner_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baner_id'] = this.banerId;
    data['baner_name'] = this.banerName;
    data['baner_text'] = this.banerText;
    return data;
  }

  void operator [](other) {}
}