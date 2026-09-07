import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class getdata {
  crud crud1;

  getdata(this.crud1);

  getdataf() async {
    var response = await crud1.postdata(Linkapi.banner, {});
    return response.fold((l) => l, (r) => r);
  }

  getitems() async {
    var response = await crud1.postdata(Linkapi.items, {});
    return response.fold((l) => l, (r) => r);
  }

  getcategory() async {
    var response = await crud1.postdata(Linkapi.homecategoty, {});
    return response.fold((l) => l, (r) => r);
  }
}
