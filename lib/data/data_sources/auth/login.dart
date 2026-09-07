import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class Logindata{

  crud crud1;
  Logindata(this.crud1);

  loginf( String email,String password)async{
    var response = await crud1.postdata(Linkapi.loginapi, {

      "email":email,
      "password":password

    });
    return response.fold((l) => l, (r) => r);

  }

}