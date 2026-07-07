import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';

class ProductWarningBanner extends StatelessWidget {
  final int stock;

  const ProductWarningBanner({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    if (stock > 5 || stock <= 0) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          color: const Color(0xFFFFF3E0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Icon(
                Icons.report_problem_outlined,
                color: const Color(0xFFE65100),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                "المنتج اقترب من النفاد — باقي $stock قطع فقط",
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFFE65100),
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildFullWidthDivider(),
      ],
    );
  }

  Widget _buildFullWidthDivider() {
    return Container(
      width: double.infinity,
      height: 1.h,
      color: AppColors.lightDivider,
    );
  }
}