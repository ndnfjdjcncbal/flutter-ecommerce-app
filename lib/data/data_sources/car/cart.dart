import '../../../core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class Cart {
  crud crud1;

  Cart(this.crud1);

  Future<dynamic> insertcartf(String user, String item, String color) async {
    var response = await crud1.postdata(Linkapi.inserintocart, {
      "cart_userid": user,
      "cart_itemid": item,
      "cart_color1": color,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deletecart(String user, String item) async {
    var response = await crud1.postdata(Linkapi.viewfavv, {
      "cart_userid": user,
      "cart_itemid": item,
    });
    return response.fold((l) => l, (r) => r);
  }

  viewcartd(String user) async {
    var response = await crud1.postdata(Linkapi.viewvart, {
      "cart_userid": user,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> viewcoloritem(String itemid) async {
    var response = await crud1.postdata(Linkapi.viewitems_color, {
      "items_id": itemid,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> cupondetails(String id, String namecupon) async {
    var response = await crud1.postdata(Linkapi.viewcoupondetails, {
      "namecupon": namecupon,
      "couponid": id,
    });
    return response.fold((l) => l, (r) => r);
  }
}
