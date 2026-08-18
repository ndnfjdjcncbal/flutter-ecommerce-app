import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class signiniwth extends StatelessWidget{
final String text;
final Widget icon;
final  void Function()? onPressed;
const signiniwth({ required this.text, required this.icon, this.onPressed});

  Widget build(BuildContext context){
    return     Container(  margin: EdgeInsets.symmetric(horizontal: 13.3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(width: 0,),
      ),
      child: MaterialButton( padding: EdgeInsets.symmetric(horizontal: 50,vertical: 15), onPressed:onPressed,child:
       Row(children: [

          Text(text,style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(width: 6.2,),

icon,

       ],),
      ),);

  }}