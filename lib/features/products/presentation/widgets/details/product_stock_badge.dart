import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_styles.dart';


class ProductStockBadge extends StatelessWidget {
  final int stock;

  const ProductStockBadge({
    super.key,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {

    final bool isOutOfStock = stock == 0;
    final bool isLow = stock > 0 && stock <= 5;
    final bool isCritical = isOutOfStock || isLow;


    final TextStyle currentTextStyle = isCritical
        ? TextStyles.font12RedRegular
        : TextStyles.font12PrimaryBlueRegular;

    final Color themeColor = currentTextStyle.color!;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 6.w,
        vertical: 2.h,
      ),
      decoration: BoxDecoration(

        color: themeColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: themeColor.withOpacity(0.15), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 5.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: themeColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            isOutOfStock
                ? "حالة المخزون: نفذ"
                : isLow
                ? "حالة المخزون: منخفض"
                : "حالة المخزون: متوفر",
            style: currentTextStyle,
          ),
        ],
      ),
    );
  }
}