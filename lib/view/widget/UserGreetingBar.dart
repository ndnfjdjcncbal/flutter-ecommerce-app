import 'package:ecommerce/view/widget/searchdelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Usergreetingbar  extends StatelessWidget {

  const Usergreetingbar({super.key, });

  @override
  Widget build(BuildContext context) {

return   Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [
    Container( margin: EdgeInsets.only(top: 20,left:12,right: 14),
        child: CircleAvatar(  radius: 35, backgroundImage:
        AssetImage("assets/hema.png") ,)),
    SizedBox(width:2),
    Container(margin: EdgeInsets.only(top: 20),
      child: Column(

        children: [
          Text(
            'Hi, ibrahem',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Let's go shopping",
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
    SizedBox(width: 60,),
    Container(margin: EdgeInsets.only(top: 20,),child: Row(children: [
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () { Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );},
      ),
      Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications_outlined),
              onPressed: () {},
            ),
            Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ))])
    ],),)

  ],
);
  }

}