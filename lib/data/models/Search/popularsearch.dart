class popularsearch {
  String? s0;
  String? s1;
  String? s2;
  String? s3;
  String? s4;
  String? s5;
  String? s6;
  String? s7;
  String? s8;
  String? s9;
  String? historysearchNamear;
  String? historysearchName;
  String? totalsearch;
  String? itemsImage;
  String? itemsPrice;
  String? itemsId;
  String? itemsName;
  String? itemsDatetime;
  String? historysearchDatetime;
  String? tag;

  popularsearch(
      {this.s0,
        this.s1,
        this.s2,
        this.s3,
        this.s4,
        this.s5,
        this.s6,
        this.s7,
        this.s8,
        this.s9,
        this.historysearchNamear,
        this.historysearchName,
        this.totalsearch,
        this.itemsImage,
        this.itemsPrice,
        this.itemsId,
        this.itemsName,
        this.itemsDatetime,
        this.historysearchDatetime,
        this.tag});

  popularsearch.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
    s8 = json['8'];
    s9 = json['9'];
    historysearchNamear = json['historysearch_namear'];
    historysearchName = json['historysearch_name'];
    totalsearch = json['totalsearch'];
    itemsImage = json['items_image'];
    itemsPrice = json['items_price'];
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsDatetime = json['items_datetime'];
    historysearchDatetime = json['historysearch_datetime'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    data['8'] = this.s8;
    data['9'] = this.s9;
    data['historysearch_namear'] = this.historysearchNamear;
    data['historysearch_name'] = this.historysearchName;
    data['totalsearch'] = this.totalsearch;
    data['items_image'] = this.itemsImage;
    data['items_price'] = this.itemsPrice;
    data['items_id'] = this.itemsId;
    data['items_name'] = this.itemsName;
    data['items_datetime'] = this.itemsDatetime;
    data['historysearch_datetime'] = this.historysearchDatetime;
    data['tag'] = this.tag;
    return data;
  }
}