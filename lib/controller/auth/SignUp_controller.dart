import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecommerce/core/classes/crud.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/counstant/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/auth/SignUp.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/servises/Mysevice.dart';
import '../../data/datasource/auth/signup.dart';

abstract class SignupController  extends GetxController{

  Signup();


}class signuoimp extends SignupController {
  String ?email1;
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  GlobalKey<FormState> formstates = GlobalKey<FormState>();
  bool isshowpass =true;
  change(){

    isshowpass=isshowpass==true?false:true;
  }
  late signuodata sign;
  Myservice myServices = Get.find();

  StatusRequest statusrequest1=StatusRequest.none;
  @override
  Signup()async {
    if(formstates.currentState!.validate()){
  statusrequest1=StatusRequest.loading;
    update();
var response=await sign.signupf(name.text,email.text,password.text);
print(response);

if(response['status']=="success"){
 statusrequest1=StatusRequest.success;
update();
 myServices.sharedPreferences.setString('Step', '2');

  Get.toNamed(approute.verfiedcode0, arguments: {'email': email.text,},

      );

}else{
  if(response['status']=="failed"){
    statusrequest1=StatusRequest.failure;
    update();
    AwesomeDialog(
      btnCancelColor: AppColors.primary,
      btnOkColor: AppColors.primary,
      context: Get.context!,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Error',
      desc: 'لم يتم انشاء الحساب',
      btnCancelOnPress: () {
      },
      btnOkOnPress: () async{
          Get.toNamed(approute.login);
        update();

      },
    )..show();


  }

  }

update();

  }}
  @override
  void onInit() {
    sign=signuodata((crud()));
    name=TextEditingController();
    email=TextEditingController();
    password=TextEditingController();

    super.onInit();
  }

}