import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_styles.dart';

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 180.w,
            height: 180.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  size: 90.sp,
                  color: const Color(0xFF1E4AB0).withOpacity(0.15),
                ),
                Positioned(
                  top: 24.h,
                  right: 24.w,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1E4AB0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.priority_high,
                      color: Colors.white,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 28.h),

          Text(
            "لم يتم إضافة أي منتجات بعد!",
            style: TextStyles.font14BlackMedium,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Text(
            "ابدأ بإضافة أول منتج لعرضه في متجرك.",
            style: TextStyles.font12DarkGreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
