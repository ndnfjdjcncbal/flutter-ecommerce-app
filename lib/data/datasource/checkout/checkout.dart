import '../../../core/classes/crud.dart';
import '../../../linkapi.dart';

class Checkout {
  crud crud1;

  Checkout(this.crud1);

  Future<dynamic> addorder(
    String userId,
    String address,
    String orderType,
    String paymentMethod,
    String price,
    String shippingPrice,
    String totalPrice,
    String countItem,
    String orderItem,
    String cupon,
    String discountco,
  ) async {
    var response = await crud1.postdata(Linkapi.chckoutorderelink, {
      "orders_userid": userId,
      "orders_adresse": address,
      "orders_type": orderType,
      "orders_paymentmethod": paymentMethod,
      "orders_price": price,
      "orders_pricedlivery": shippingPrice,
      "orders_totalprice": totalPrice,
      "countitem": countItem,
      "orders_item": orderItem,
      "orders_cupon": cupon,
      "discountco": discountco,
    });

    return response.fold((l) => l, (r) => r);
  }
}
