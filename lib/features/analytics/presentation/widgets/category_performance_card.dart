import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/full_analytics_entity.dart';

class CategoryPerformanceCard extends StatelessWidget {
  final List<AnalyticsCategoryEntity> categories;

  const CategoryPerformanceCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(color: AppColors.authBgColor, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("أداء الفئات", style: TextStyles.font12darkTextMedium),
          SizedBox(height: 12.h),
          ...List.generate(
            categories.length,
                (index) => _buildCategoryProgress(
              categories[index].category,
              categories[index].sharePct / 100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryProgress(String label, double value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, color: const Color(0xFF313131))),
              Text("${(value * 100).toStringAsFixed(0)}%", style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF6B7280))),
            ],
          ),
          SizedBox(height: 4.h),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: 6.h,
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r), color: const Color(0xFFE2E8F0)),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        width: constraints.maxWidth * value,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5990D3), Color(0xFF0052B5)],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}