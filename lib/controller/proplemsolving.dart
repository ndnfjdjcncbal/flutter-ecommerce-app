List<String?> prices = ['120', null, '45.5', 'abc', '30'];
List<int> numbers = [45, 12, 88, 34, 88, 5, 91, 23];

double sum(List<String?> prices) {
  double count = 0;
  for (int price = 0; price < prices.length; price++) {
    count += double.tryParse(prices[price] ?? '0') ?? 0;
  }
  return count;
}

int getsecondslargenumber(List<int> numbers) {
  int largenumber = -999999;
  int secondslargnumber = -999999;
  for (int i = 0; i < numbers.length; i++) {
    if (numbers[i] > largenumber) {
      secondslargnumber = largenumber;
      largenumber = numbers[i];
    } else if (numbers[i] > secondslargnumber) {
      secondslargnumber = numbers[i];
    }
  }
  return secondslargnumber;
}

class CartItem {
  final String productId;
  final String color;
  final int quantity;

  CartItem({
    required this.productId,
    required this.color,
    required this.quantity,
  });
}

List<CartItem> cartItems = [
  CartItem(productId: 'P1', color: 'أحمر', quantity: 2),
  CartItem(productId: 'P2', color: 'أزرق', quantity: 1),
  CartItem(productId: 'P1', color: 'أزرق', quantity: 3),
  CartItem(productId: 'P3', color: 'أخضر', quantity: 5),
  CartItem(productId: 'P2', color: 'أحمر', quantity: 4),
];

Map<String, int> groupQuantities(List<CartItem> cartItems) {
  Map<String, int> result = {};
  for (int i = 0; i < cartItems.length; i++) {
    String currentId = cartItems[i].productId;
    int currentQty = cartItems[i].quantity;
    if (result.containsKey(currentId)) {
      currentQty = result[currentId]! + currentQty;
      result[currentId] = currentQty;
    } else {
      result.addAll({currentId: currentQty});
    }
  }
  return result;
}
