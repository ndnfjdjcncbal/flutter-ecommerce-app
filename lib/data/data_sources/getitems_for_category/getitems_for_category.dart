import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/linkapi.dart';

class GetitemsForCategoryData {
  final crud crud1;

  GetitemsForCategoryData(this.crud1);

  Future<dynamic> getItemsByCategory(String categoryId) async {
    final response = await crud1.postdata(Linkapi.itemsForCategory, {
      'category_id': categoryId,
    });
    return response.fold((left) => left, (right) => right);
  }
}
