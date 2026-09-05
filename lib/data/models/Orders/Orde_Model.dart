class OrderModel1 {
  String? ordersId;
  String? ordersAddress;
  String? ordersTotalprice;
  String? orderPayment;
  String? orderStatus;
  String? orderUserid;
  String? orderType;
  String? orderCountitem;
  String? orderCuponDiscount;
  String? ordersShipping;
  String? ordersCupon;
  String? orderDatetime;
  String? ordersItem;
  String? itemscolorId;
  String? namecolorAr;
  String? namecolorEn;
  String? itemscolorQuantity;
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

  OrderModel1({
    this.ordersId,
    this.ordersAddress,
    this.ordersTotalprice,
    this.orderPayment,
    this.orderStatus,
    this.orderUserid,
    this.orderType,
    this.orderCountitem,
    this.orderCuponDiscount,
    this.ordersShipping,
    this.ordersCupon,
    this.orderDatetime,
    this.ordersItem,
    this.itemscolorId,
    this.namecolorAr,
    this.namecolorEn,
    this.itemscolorQuantity,
    this.itemsId,
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
    this.itemsLocationar,
  });

  OrderModel1.fromJson(Map<String, dynamic> json) {
    ordersId = json['orders_id'];
    ordersAddress = json['orders_address'];
    ordersTotalprice = json['orders_totalprice'];
    orderPayment = json['order_payment'];
    orderStatus = json['order_status'];
    orderUserid = json['order_userid'];
    orderType = json['order_type'];
    orderCountitem = json['order_countitem'];
    orderCuponDiscount = json['order_cupon_discount'];
    ordersShipping = json['orders_shipping'];
    ordersCupon = json['orders_cupon'];
    orderDatetime = json['order_datetime'];
    ordersItem = json['orders_item'];
    itemscolorId = json['itemscolor_id'];
    namecolorAr = json['namecolor_ar'];
    namecolorEn = json['namecolor_en'];
    itemscolorQuantity = json['itemscolor_quantity'];
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
    data['orders_id'] = this.ordersId;
    data['orders_address'] = this.ordersAddress;
    data['orders_totalprice'] = this.ordersTotalprice;
    data['order_payment'] = this.orderPayment;
    data['order_status'] = this.orderStatus;
    data['order_userid'] = this.orderUserid;
    data['order_type'] = this.orderType;
    data['order_countitem'] = this.orderCountitem;
    data['order_cupon_discount'] = this.orderCuponDiscount;
    data['orders_shipping'] = this.ordersShipping;
    data['orders_cupon'] = this.ordersCupon;
    data['order_datetime'] = this.orderDatetime;
    data['orders_item'] = this.ordersItem;
    data['itemscolor_id'] = this.itemscolorId;
    data['namecolor_ar'] = this.namecolorAr;
    data['namecolor_en'] = this.namecolorEn;
    data['itemscolor_quantity'] = this.itemscolorQuantity;
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
