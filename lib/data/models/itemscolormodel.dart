class colormodelitems {
  String? itemscolorId;
  String? namecolorAr;
  String? namecolorEn;
  String? itemId;
  String? itemscolorQuantity;

  colormodelitems({
    this.itemscolorId,
    this.namecolorAr,
    this.namecolorEn,
    this.itemId,
    this.itemscolorQuantity,
  });

  colormodelitems.fromJson(Map<String, dynamic> json) {
    itemscolorId = json['itemscolor_id'];
    namecolorAr = json['namecolor_ar'];
    namecolorEn = json['namecolor_en'];
    itemId = json['item_id'];
    itemscolorQuantity = json['itemscolor_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemscolor_id'] = this.itemscolorId;
    data['namecolor_ar'] = this.namecolorAr;
    data['namecolor_en'] = this.namecolorEn;
    data['item_id'] = this.itemId;
    data['itemscolor_quantity'] = this.itemscolorQuantity;
    return data;
  }
}
