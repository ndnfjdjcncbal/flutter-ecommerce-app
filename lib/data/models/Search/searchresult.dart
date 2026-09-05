class modelsearch {
  String? itemsId;
  String? itemsName;
  String? itemsImage;
  String? itemsDatetime;
  String? itemsPrice;
  String? itemsCategort;
  String? itemsDesc;
  String? itemsDescAr;
  String? itemnameAR;
  String? itemsCount;
  String? itemsColor;
  String? itemsColorar;
  String? itemsLocation;
  String? itemsLocationar;

  modelsearch(
      {this.itemsId,
        this.itemsName,
        this.itemsImage,
        this.itemsDatetime,
        this.itemsPrice,
        this.itemsCategort,
        this.itemsDesc,
        this.itemsDescAr,
        this.itemnameAR,
        this.itemsCount,
        this.itemsColor,
        this.itemsColorar,
        this.itemsLocation,
        this.itemsLocationar});

  modelsearch.fromJson(Map<String, dynamic> json) {
    itemsId = json['items_id'];
    itemsName = json['items_name'];
    itemsImage = json['items_image'];
    itemsDatetime = json['items_datetime'];
    itemsPrice = json['items_price'];
    itemsCategort = json['items_categort'];
    itemsDesc = json['items_desc'];
    itemsDescAr = json['items_descAr'];
    itemnameAR = json['itemname_AR'];
    itemsCount = json['items_count'];
    itemsColor = json['items_color'];
    itemsColorar = json['items_colorar'];
    itemsLocation = json['items_location'];
    itemsLocationar = json['items_locationar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['items_id'] = this.itemsId;
    data['items_name'] = this.itemsName;
    data['items_image'] = this.itemsImage;
    data['items_datetime'] = this.itemsDatetime;
    data['items_price'] = this.itemsPrice;
    data['items_categort'] = this.itemsCategort;
    data['items_desc'] = this.itemsDesc;
    data['items_descAr'] = this.itemsDescAr;
    data['itemname_AR'] = this.itemnameAR;
    data['items_count'] = this.itemsCount;
    data['items_color'] = this.itemsColor;
    data['items_colorar'] = this.itemsColorar;
    data['items_location'] = this.itemsLocation;
    data['items_locationar'] = this.itemsLocationar;
    return data;
  }
}