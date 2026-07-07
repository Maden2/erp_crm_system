import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_styles.dart';

class LowStockAlertCard extends StatelessWidget {
  final String productName;
  final int remainingQuantity;

  const LowStockAlertCard({
    super.key,
    required this.productName,
    required this.remainingQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h), //[cite: 9]
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h), //[cite: 9]
      decoration: BoxDecoration(
        color: const Color(0x80FDEAB6), //[cite: 9]
        borderRadius: BorderRadius.circular(10.r), //[cite: 9]
        border: Border.all(color: const Color(0xFFE45D32), width: 1.w), //[cite: 9]
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.r), //[cite: 9]
            decoration: BoxDecoration(
              color: const Color(0x1AE45D32), //[cite: 9]
              borderRadius: BorderRadius.circular(8), //[cite: 9]
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange, //[cite: 9]
              size: 16.sp, //[cite: 9]
            ),
          ),
          SizedBox(width: 12.w), //[cite: 9]
          Expanded(
            child: Text(
              "المنتج \"$productName\" اقترب من النفاد – باقي $remainingQuantity قطع فقط", //[cite: 9]
              textDirection: TextDirection.rtl, //[cite: 9]
              style: TextStyles.font10AlertMedium, //[cite: 9]
              overflow: TextOverflow.ellipsis, //[cite: 9]
              maxLines: 2, //[cite: 9]
            ),
          ),
        ],
      ),
    );
  }
}