import '../../../core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class Addres {
  crud crud1;

  Addres(this.crud1);

  Future<dynamic> addAddress({
    required String userId,
    required String country,
    required String city,
    required String street,
    required String lat,
    required String long,
  }) async {
    var response = await crud1.postdata(Linkapi.addaddres, {
      "userid": userId,
      "country": country,
      "city": city,
      "street": street,
      "lat": lat,
      "long": long,
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

  viewaddresf(String user) async {
    var response = await crud1.postdata(Linkapi.viewaddres, {
      "addresuserid": user,
    });
    return response.fold((l) => l, (r) => r);
  }

  viewlatestaddres(String user) async {
    var response = await crud1.postdata(Linkapi.viewlatestaddres, {
      "addresuserid": user,
    });
    return response.fold((l) => l, (r) => r);
  }
}
