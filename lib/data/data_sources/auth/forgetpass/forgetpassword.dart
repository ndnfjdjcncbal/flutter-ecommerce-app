import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';

class forgetpassdata{

  crud crud1;
  forgetpassdata(this.crud1);

  forgetpassf( String email)async{
    var response = await crud1.postdata(Linkapi.forgetpasswordlink, {
      "email":email,
    });
    return response.fold((l) => l, (r) => r);

  }

  checkcodelogin( String email,String verified)async{
    var response = await crud1.postdata(Linkapi.checkcodelogin, {
      "email":email,
      "verified":verified,

    });
    return response.fold((l) => l, (r) => r);

  }

  resetpassf( String email,String pass)async{
    var response = await crud1.postdata(Linkapi.resetpass, {
      "email":email,
      "password":pass

    });
    return response.fold((l) => l, (r) => r);

  }

}