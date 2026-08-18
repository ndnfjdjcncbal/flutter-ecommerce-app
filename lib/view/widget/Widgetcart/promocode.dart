import 'package:ecommerce/core/counstant/colore.dart';
import 'package:flutter/material.dart';

class CartSummarySection extends StatelessWidget {
  final TextEditingController promoController;
  final double subtotal;
  final double shipping;
  final double total;
  final VoidCallback onCheckout;
  final VoidCallback? onApplyPromo;

  const CartSummarySection({
    super.key,
    required this.promoController,
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.onCheckout,
    this.onApplyPromo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 40, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  color: Colors.grey.shade500,
                  size: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: promoController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter your promo code',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onApplyPromo,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey.shade500,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          _SummaryRow(title: 'Subtotal', value: subtotal),
          SizedBox(height: 10),

          _SummaryRow(title: 'Shipping', value: shipping),
          SizedBox(height: 14),

          CustomPaint(
            size: Size(double.infinity, 1),
            painter: _DashedLinePainter(),
          ),
          SizedBox(height: 14),

          _SummaryRow(title: 'Total amount', value: total, isBold: true),
          SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Checkout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String title;
  final double value;
  final bool isBold;

  const _SummaryRow({
    required this.title,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 15 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.black : Colors.grey.shade600,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: isBold ? 17 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// الخط المتقطع
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    double dashWidth = 5, dashSpace = 3, startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
