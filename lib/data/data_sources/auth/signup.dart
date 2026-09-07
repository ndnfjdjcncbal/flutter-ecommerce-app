import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class signuodata{

  crud crud1;
  signuodata(this.crud1);
  
  signupf(String name, String email,String password)async{
    var response =await crud1.postdata(Linkapi.signupl, {

      "name":name,
      "email":email,
      "password":password

    });
    return response.fold((l) => l, (r) => r);
    
  }
  
}