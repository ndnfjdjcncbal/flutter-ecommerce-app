import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class verfiecodes{

  crud crud1;
  verfiecodes(this.crud1);

  verfiecodef( String email,String verified)async{
    var response =await crud1.postdata(Linkapi.verifiedcodesignup, {

      "email":email,
      "verified":verified
    });
    return response.fold((l) => l, (r) => r);

  }
  resendcode( String email)async{
    var response =await crud1.postdata(Linkapi.resendcode, {

      "email":email,

    });
    return response.fold((l) => l, (r) => r);

  }

}