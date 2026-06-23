import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/analytics_entity.dart';
import '../manager/analytics_cubit.dart';
import '../manager/analytics_state.dart';

class TopProductsSection extends StatelessWidget {
  const TopProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        if (state is AnalyticsLoading) {
          return SizedBox(
            height: 100.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AnalyticsSuccess) {
          final products = state.analytics.topProducts;
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.authBgColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 4.w),
                  child: Text(
                    'المنتجات الأكثر مبيعاً',
                    style: TextStyles.font12darkTextMedium,
                  ),
                ),
                SizedBox(height: 12.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: products.asMap().entries.map((entry) {
                      final i = entry.key;
                      final product = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(
                          left: i == products.length - 1 ? 0 : 8.w,
                        ),
                        child: _buildProductCard(product),
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

  Widget _buildProductCard(TopProductEntity product) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: AppColors.homeBg,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              product.image,
              width: 36.w,
              height: 36.w,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(Icons.image, color: Colors.grey, size: 20.sp),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF313131),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${product.salesCount} وحدة مباعة • ${product.totalRevenue.toStringAsFixed(0)} ج.م',
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 7.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Icon(Icons.chevron_left, size: 16.sp, color: const Color(0xFF6B7280)),
        ],
      ),
    );
  }
}
