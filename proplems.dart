void main() {
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

  List<int> nums = [2, 7, 11, 15];

  List<int> returnoutput(nums) {
    List<int> fanalresult8 = [];
    final target = 9;
    for (var i = 0; i < nums.length; i++) {
      for (var j = 0; j < nums.length; j++) {
        if (nums[i] + nums[j] == target && i != j) {
          fanalresult8 = [i, j];
          print(fanalresult8);
          return fanalresult8;
        }
      }
    }
    return fanalresult8;
  }
}
