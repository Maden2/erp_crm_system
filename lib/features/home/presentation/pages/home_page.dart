import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

import '../manager/dashboard_home_cubit.dart';
import '../manager/dashboard_chart_cubit.dart';

import '../widgets/home_banner.dart';
import '../widgets/stats_section.dart';
import '../widgets/sales_chart_section.dart';
import '../widgets/low_stock_section.dart';
import '../widgets/latest_support_ticket_section.dart';
import '../widgets/empty_home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<DashboardHomeCubit>()..loadDashboardHome(period: "daily"),
        ),
        BlocProvider(
          create: (_) => getIt<DashboardChartCubit>()..loadDashboardChart(period: "daily"),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        body: SafeArea(
          child: BlocBuilder<DashboardHomeCubit, DashboardHomeState>(
            builder: (context, state) {
              if (state is DashboardHomeLoading) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(child: EmptyHomeState()),
                );
              }

              if (state is DashboardHomeSuccess) {
                final dashboardData = state.dashboardData;

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<DashboardHomeCubit>().loadDashboardHome();
                    context.read<DashboardChartCubit>().loadDashboardChart(period: "daily");
                  },
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),

                        // 🟢 رجع يقرأ الـ greeting فقط زي ما طلبت بالظبط لتجنب أي إيرور
                        HomeBanner(
                          greeting: dashboardData.greeting,
                        ),

                        SizedBox(height: 24.h),

                        Text("أهم المؤشرات", style: TextStyles.font14BlackMedium),
                        SizedBox(height: 16.h),

                        StatsSection(kpi: dashboardData.kpi, profit: dashboardData.profit),

                        SizedBox(height: 24.h),

                        BlocBuilder<DashboardChartCubit, DashboardChartState>(
                          builder: (context, chartState) {
                            if (chartState is DashboardChartLoading) {
                              return SizedBox(
                                height: 200.h,
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            }

                            if (chartState is DashboardChartSuccess) {
                              return SalesChartSection(
                                chartData: chartState.chartPoints,
                                selectedFilter: chartState.selectedPeriod,
                              );
                            }

                            return const SizedBox();
                          },
                        ),

                        SizedBox(height: 24.h),

                        LowStockSection(products: dashboardData.lowStock),

                        SizedBox(height: 24.h),

                        // كارت الإشعارات الأخير بالداتا اللايف تحت
                        if (dashboardData.notifications.isNotEmpty)
                          LatestSupportTicketSection(notification: dashboardData.notifications.first),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                );
              }

              if (state is DashboardHomeError) {
                return Center(child: Text(state.message, style: TextStyles.font14BlackMedium));
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}