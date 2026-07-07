import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_assets.dart';
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
            child: SvgPicture.asset(
              AppAssets.emptyProductsIcon,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 28.h),

          Text(
            "لم يتم إضافة أي منتجات بعد!",
            style: TextStyles.font20DarkGreyMedium,
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 8.h),

          Text(
            "ابدأ بإضافة أول منتج لعرضه في متجرك.",
            style: TextStyles.font14DarkGreyRegular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}