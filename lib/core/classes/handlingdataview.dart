import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Handlingdataview extends StatelessWidget{
  final StatusRequest statusRequest;
  final Widget widget;

  Handlingdataview({required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context){
    return statusRequest == StatusRequest.loading
        ? Center(
      child: Center(child: CircularProgressIndicator()),
    )
        : statusRequest == StatusRequest.offlinefailure
        ? Center(
      child: Text("offlinefailure ..."),
    )
        : statusRequest == StatusRequest.serverfailure
        ? Center(
      child: Text("serverfailure ..."),
    )
        : statusRequest == StatusRequest.failure
        ? Center(
      child: Text("No Data ..."),
    )
        : widget;
}}