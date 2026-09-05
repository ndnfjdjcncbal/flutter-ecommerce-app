import '../../../core/classes/crud.dart';
import '../../../linkapi.dart';

class Search {
  crud crud1;

  Search(this.crud1);

  searchitems(String itemname) async {
    var response = await crud1.postdata(Linkapi.Search, {
      "itemsname": itemname,
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

  getsearch(String user) async {
    var response = await crud1.postdata(Linkapi.getistory, {"userid": user});
    return response.fold((l) => l, (r) => r);
  }

  clearhistory(String user) async {
    var response = await crud1.postdata(Linkapi.clearhist, {"userid": user});
    return response.fold((l) => l, (r) => r);
  }

  deleteitemhistorry(String user, String itemid) async {
    var response = await crud1.postdata(Linkapi.deleteidhist, {
      "userid": user,
      "itmeid": itemid,
    });
    return response.fold((l) => l, (r) => r);
  }

  popularsearchnofilter() async {
    var response = await crud1.postdata(Linkapi.popularsearch, {});
    return response.fold((l) => l, (r) => r);
  }

  saveUserChoices() async {
    var response = await crud1.postdata(Linkapi.Getcolorandlocation, {});
    return response.fold((l) => l, (r) => r);
  }

  Filterby(
    String color,
    String itemminprice,
    String itemmaxprice,
    String itemname,
  ) async {
    var response = await crud1.postdata(Linkapi.Filterby, {
      "itemcolor": color,
      "itemminprice": itemminprice,
      "itemmaxprice": itemmaxprice,
      "itemname": itemname,
    });
    return response.fold((l) => l, (r) => r);
  }
}
