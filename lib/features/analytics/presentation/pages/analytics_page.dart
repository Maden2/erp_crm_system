import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/full_analytics_cubit.dart';
import '../manager/full_analytics_state.dart';
import '../widgets/analytics_header.dart';
import '../widgets/sales_summary_card.dart';
import '../widgets/sales_chart_widget.dart';
import '../widgets/top_products_section.dart';
import '../widgets/category_performance_card.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FullAnalyticsCubit>()..getAnalytics(period: 'daily'),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        body: BlocBuilder<FullAnalyticsCubit, FullAnalyticsState>(
          builder: (context, state) {
            if (state is FullAnalyticsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is FullAnalyticsSuccess) {
              final analytics = state.analytics;

              // 🟢 التحقق الفوري لو الباكيند باعت الداتا صفر أو لست الفئات والمنتجات فاضية لعرض شاشة الترحيب والتهيئة
              bool isDataEmpty = analytics.topProducts.isEmpty && analytics.categories.isEmpty;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const AnalyticsHeader(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),

                          // عنوان الترحيب بالشاشة الفاضية
                          if (isDataEmpty) ...[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "لا توجد بيانات تحليلية حتى الآن",
                                style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B)),
                              ),
                            ),
                          ],

                          const SalesSummaryCard(),
                          SizedBox(height: 16.h),

                          // 🟢 عرض الـ 3 خطوات لتهيئة الحساب والزرار الأزرق لما تكون الداتا صفر طبق الأصل من فيجما
                          if (isDataEmpty) ...[
                            SizedBox(height: 8.h),
                            _buildWelcomeStep("1", "أضف منتجاتك", "لبدء عمليات البيع."),
                            _buildWelcomeStep("2", "استقبل أول طلب", "لتفعيل التقارير."),
                            _buildWelcomeStep("3", "تابع الأداء", "من خلال لوحة التحليلات."),
                            SizedBox(height: 16.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0D1B5E),
                                minimumSize: Size(double.infinity, 45.h),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                              ),
                              onPressed: () {},
                              child: Text("+ أضف أول منتج", style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(height: 24.h),
                          ] else ...[
                            // لو في داتا اعرض الشارت العادي
                            const SalesChartWidget(),
                            SizedBox(height: 16.h),
                          ],

                          const TopProductsSection(),
                          SizedBox(height: 16.h),

                          if (!isDataEmpty) ...[
                            CategoryPerformanceCard(categories: analytics.categories),
                          ] else ...[
                            // السلوت الفاضي الأخير لأداء الفئات بالشاشة الفاضية
                            Container(
                              width: double.infinity,
                              height: 60.h,
                              decoration: BoxDecoration(color: AppColors.authBgColor, borderRadius: BorderRadius.circular(12.r)),
                              child: Center(child: Text("لا توجد بيانات بعد", style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: Colors.grey))),
                            )
                          ],
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  // ويدجيت الخطوة الفرعية للتهيئة والترحيب
  Widget _buildWelcomeStep(String number, String title, String subtitle) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(color: AppColors.authBgColor, borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: const BoxDecoration(color: Color(0xFFEFF2FE), shape: BoxShape.circle),
            child: Center(child: Text(number, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D1B5E)))),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Text(title, style: TextStyle(fontFamily: 'Cairo', fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B))),
                Text(subtitle, style: TextStyle(fontFamily: 'Cairo', fontSize: 9.sp, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}