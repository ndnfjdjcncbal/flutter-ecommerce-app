import '../../../core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class Orders {
  crud crud1;

  Orders(this.crud1);

  Getorders(String userid) async {
    var response = await crud1.postdata(Linkapi.getorders, {
      "orders_userid": userid,
    });
    return response.fold((l) => l, (r) => r);
  }

  historysearch(
    String historyname,
    String historynamear,
    String user,
    String id,
  ) async {
    var response = await crud1.postdata(Linkapi.Searchhistory, {
      "hostoryname": historyname,
      "hostorynamear": historynamear,
      "user": user,
      "itemid": id,
    });
    return response.fold((l) => l, (r) => r);
  }
}
