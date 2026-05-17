import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/analytics_entity.dart';

class CategoryPerformanceCard extends StatelessWidget {
  final List<CategoryPerformanceEntity> categories;

  const CategoryPerformanceCard({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "أداء الفئات",
            style: TextStyles.font12darkTextMedium,
          ),
          SizedBox(height: 12.h),
          ...List.generate(
            categories.length,
                (index) => _buildCategoryProgress(
              categories[index].label,
              categories[index].percentage / 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProgress(
      String label,
      double value,
      ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl, 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF313131),
                ),
              ),
              Text(
                "${(value * 100).toInt()}%",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 7.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: const Color(0xFFE2E8F0),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: constraints.maxWidth * value,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(71.r),
                          gradient: const LinearGradient(
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                            colors: [
                              Color(0xFF5990D3),

                              Color(0xFF0052B5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}