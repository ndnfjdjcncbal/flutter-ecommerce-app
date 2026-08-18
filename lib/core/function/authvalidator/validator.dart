import 'package:get/get.dart';

validinput(String val,int min,int max,String type){
  if(type=='username'){
    if(!GetUtils.isUsername(val)){
      return "Not valid username";
    }

  }
  if(type=='email'){
    if(!GetUtils.isEmail(val)){
      return "Not valid email";
    }

  }
  if(type=='password'){
    if(val.isEmpty){
      return "Not valid password";
    }

  }
  if(val.length<min){
    return "can't be less than $min";


  }
  if (val.length > max) {
    return "can't be larger than $max";
  }
  if (val.isEmpty) {
    return "can't be Empty";
  }else {
    return null;
  }
}