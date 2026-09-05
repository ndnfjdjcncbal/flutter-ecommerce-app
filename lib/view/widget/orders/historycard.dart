import 'package:ecommerce/core/constants/colore.dart';

import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String color;
  final String qty;
  final String price;
  final String image;

  const HistoryCard({
    Key? key,
    required this.title,
    required this.color,
    required this.qty,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F0EA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.network(image),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Color: $color",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9A9AA8),
                          ),
                        ),
                        Text(
                          "Qty: $qty",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9A9AA8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(width: 8),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "\$ $price",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    color: AppColors.primary,
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Details",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: -6,
          right: 12,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Text(
              "Completed",
              style: TextStyle(
                color: Colors.green,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
