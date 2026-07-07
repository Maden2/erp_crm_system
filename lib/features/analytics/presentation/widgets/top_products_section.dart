import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../manager/full_analytics_cubit.dart';
import '../manager/full_analytics_state.dart';

class TopProductsSection extends StatelessWidget {
  const TopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullAnalyticsCubit, FullAnalyticsState>(
      builder: (context, state) {
        if (state is FullAnalyticsSuccess) {
          final products = state.analytics.topProducts;

          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.authBgColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text('المنتجات الأكثر مبيعاً', style: TextStyles.font12darkTextMedium),
                ),
                SizedBox(height: 12.h),
                // 🟢 لو الداتا فاضية بنعرض السلوتس الرمادية الفاضية الرايقة اللّي في الفيجما تماماً
                products.isEmpty
                    ? Row(
                  textDirection: TextDirection.rtl,
                  children: List.generate(2, (index) => Expanded(
                    child: Container(
                      height: 54.h,
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: AppColors.homeBg,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  )),
                )
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: products.asMap().entries.map((entry) {
                      final i = entry.key;
                      final product = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(left: i == products.length - 1 ? 0 : 8.w),
                        child: Container(), // كارت المنتج الفردي بتاعك هنا
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}