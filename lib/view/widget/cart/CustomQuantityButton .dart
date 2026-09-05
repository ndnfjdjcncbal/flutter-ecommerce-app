import 'package:flutter/material.dart';

class CustomQuantityButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomQuantityButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        minWidth: 0,
        onPressed: onPressed,
        child: Icon(icon, size: 16),
      ),
    );
  }
}
