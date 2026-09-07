import '../../../core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class Payment {
  crud crud1;
  Payment(this.crud1);

  Future<dynamic> viewlatestnumber(String user) async {
    var response = await crud1.postdata(Linkapi.getnumbercart, {
      "user_id": user,
    });
    return response.fold((l) => l, (r) => r);
  }
}
