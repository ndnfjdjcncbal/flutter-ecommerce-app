import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../../../core/classes/statusrequest.dart';
import '../../../core/counstant/colore.dart';
import '../../../core/function/obsecure.dart';
import '../materialbutton.dart';

class ForgetPasswordSheet extends StatelessWidget{
  StatusRequest  statusRequest=StatusRequest.none;

  final RxBool isEmailValid;
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final  void Function()? onPressed;

   ForgetPasswordSheet({
    super.key, required this.isEmailValid, required this.formKey, required this.emailController,  this.onPressed,

  });
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // ← بيرفع الشيت فوق الكيبورد
      ),        child: Container( height: 870,width: double.infinity,
      padding: EdgeInsets.all(16), decoration: BoxDecoration(color:
      AppColors.white,borderRadius: BorderRadius.circular(20))
      ,child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(  crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(height: 9,),
          Text("Forget Password",style: TextStyle(color:
          AppColors.black,fontWeight: FontWeight.w600,fontSize: 14),textAlign: TextAlign.start,),
          SizedBox(height: 9,),
          Text("Enter Your email or phone number",style: TextStyle(color:
          AppColors.grey,fontWeight: FontWeight.w400,fontSize: 13),textAlign: TextAlign.start,),
          SizedBox(height: 19,),
          Text("Email or Phone Number ",style: TextStyle(fontWeight: FontWeight.w500),),
          SizedBox(height: 10,),
          Container(     // ← خلفية رمادية فاتحة
            padding: EdgeInsets.symmetric(vertical:10), decoration: BoxDecoration(borderRadius:
          BorderRadius.circular(16)),child: Form(  key:formKey , child: TextFormField(     controller: emailController,onChanged: (val) {


            isEmailValid.value =
                val.isEmail && val.contains('@') && val.contains('.');
          },

            textAlign: TextAlign.end ,
            decoration: InputDecoration(

              enabledBorder: OutlineInputBorder(

                borderRadius: BorderRadius.circular(19),
                borderSide: BorderSide(color: Colors.grey, width: 0),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
              ),

              hintText: "Write your email",

              prefixIcon: Obx(() => isEmailValid.value
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.check_box_outlined)),

              suffixIcon: Icon(
                Icons.email_outlined,
                color: AppColors.primary,
                size: 30.5,
              ),
            )
          ),

          ),),
          SizedBox(height: 23,),
          Materialbutton(text: 'Send Code', onPressed:onPressed
          )],),
      ) ,),
    );

  }




}