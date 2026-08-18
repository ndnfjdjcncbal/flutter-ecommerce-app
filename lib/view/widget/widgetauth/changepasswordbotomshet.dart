import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../core/classes/statusrequest.dart';
import '../../../core/counstant/colore.dart';
import '../../../core/function/authvalidator/validator.dart';
import '../materialbutton.dart';

class ChangePasswordSheet extends StatelessWidget {
  final GlobalKey<FormState> formstatel2;
  final TextEditingController pass1;
  final TextEditingController pass2;
  final StatusRequest statusRequest;
  final bool ?obscureText;
  final void Function()? onTapl;

  final Function(String, String) onSubmit;

  const ChangePasswordSheet({
    Key? key,
    required this.formstatel2,
    required this.pass1,
    required this.pass2,
    required this.statusRequest,
    required this.onSubmit,
    this.obscureText, this.onTapl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 15),
          Text(
            "Create New Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          SizedBox(height: 9),
          Text(
            "Enter Your Password",
            style: TextStyle(color: AppColors.grey, fontSize: 12),
          ),
          SizedBox(height: 20),
          Text(
            "Password",
            style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Form(
            key: formstatel2,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _PasswordField(
                  onTapl: (){},
                  obscureText: obscureText==null||false?false:true,
                  controller: pass1,
                  hintText: "New Password",
                ),
                SizedBox(height: 12),
                _PasswordField(obscureText: obscureText==null||false?false:true,
                  onTapl: (){},

                  controller: pass2,
                  hintText: "Confirm Password",
                ),
              ],
            ),
          ),
          SizedBox(height: 14),
          Materialbutton(
            text: 'Change Password',
            onPressed: () async {
              if (formstatel2.currentState!.validate()) {
                if (pass1.text != pass2.text) {
                  Get.defaultDialog(
                    title: "Warning",
                    middleText: "كلمتا المرور غير متطابقتين",
                  );
                } else {
                  onSubmit(pass1.text, pass2.text);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

// ── حقل الباسورد منفصل ──────────────────────────
class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
final bool? obscureText;
final void Function()? onTapl;
  const _PasswordField( {
    required this.controller,
    required this.hintText,
    this.obscureText,
    this.onTapl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: TextFormField(

        controller: controller,
        obscureText: true,
        validator: (val) => validinput(val!, 10, 40, "password"),
        textAlign: TextAlign.end,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
            borderSide: BorderSide(color: Colors.grey, width: 0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
          hintText: hintText,
          suffixIcon: InkWell(onTap: onTapl,child: Icon(Icons.lock_outline, color: AppColors.primary, size: 30.5)),
        ),
      ),
    );
  }
}