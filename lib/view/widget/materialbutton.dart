import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/constants/colore.dart';

class Materialbutton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const Materialbutton({t, required this.text, required this.onPressed});

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.primary,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          child: Text(text, style: TextStyle(color: AppColors.white)),
        ),
      ),
    );
  }
}
