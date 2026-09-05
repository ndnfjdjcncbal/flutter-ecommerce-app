import '../../../core/classes/crud.dart';
import '../../../linkapi.dart';

class favorite {
  crud crud1;

  favorite(this.crud1);

  insertfavf(item, user) async {
    var response = await crud1.postdata(Linkapi.favv, {
      "itemid": item,

      "userid": user,
    });
    return response.fold((l) => l, (r) => r);
  }

  viewtfavf(item, user) async {
    var response = await crud1.postdata(Linkapi.viewfavv, {
      "userid": user,
      "itemsname": item,
    });
    return response.fold((l) => l, (r) => r);
  }

  viewtfavnosearchf() async {
    var response = await crud1.postdata(Linkapi.viewfavvnosearch, {});
    return response.fold((l) => l, (r) => r);
  }
}
