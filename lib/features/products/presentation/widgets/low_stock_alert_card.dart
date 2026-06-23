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
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0x80FDEAB6),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE45D32), width: 1.w),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              color: Color(0x1AE45D32),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "المنتج \"$productName\" اقترب من النفاد – باقي $remainingQuantity قطع فقط",
              textDirection: TextDirection.rtl,
              style: TextStyles.font10AlertMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
