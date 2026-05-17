import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/analytics_cubit.dart';
import '../manager/analytics_state.dart';
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
      create: (context) => getIt<AnalyticsCubit>()..fetchAnalytics(),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
          builder: (context, state) {

            if (state is AnalyticsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AnalyticsError) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is AnalyticsSuccess) {
              final analytics = state.analytics;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const AnalyticsHeader(),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),

                          const SalesSummaryCard(),

                          SizedBox(height: 16.h),
                          const SalesChartWidget(),

                          SizedBox(height: 16.h),
                          const TopProductsSection(),

                          SizedBox(height: 16.h),

                          CategoryPerformanceCard(
                            categories: analytics.categoryPerformance,
                          ),

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
}