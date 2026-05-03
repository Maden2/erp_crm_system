import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:pivot/features/home/domain/entities/home_banner_entity.dart';
import 'package:pivot/features/home/domain/entities/home_stats_entity.dart';
import '../../../../core/di/service_locator.dart';
import '../manager/latest_support_ticket_cubit.dart';
import '../manager/low_stock_cubit.dart';
import '../manager/sales_chart_cubit.dart';
import '../widgets/home_banner.dart';
import '../widgets/empty_home_state.dart';
import '../widgets/latest_support_ticket_section.dart';
import '../widgets/low_stock_section.dart';
import '../widgets/stats_section.dart';
import '../widgets/sales_chart_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool hasData = true;

    final homeBannerData = HomeBannerEntity(
      userName: "مادن",
      orderNumber: "2483",
    );

    final statsData = HomeStatsEntity(
      salesValue: "24,000",
      salesPercentage: "12%",
      profitsValue: "390,800",
      profitsPercentage: "8%",
      ordersValue: "145",
      ordersPercentage: "20%",
      reportsValue: "90,000",
      reportsPercentage: "25%",
    );

    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              HomeBanner(data: homeBannerData),
              SizedBox(height: 24.h),
              Text("أهم المؤشرات", style: TextStyles.font14BlackMedium),
              SizedBox(height: 16.h),

              if (hasData)
                StatsSection(data: statsData)
              else
                const EmptyHomeState(),

              SizedBox(height: 24.h),


              BlocBuilder<SalesChartCubit, SalesChartState>(
                builder: (context, state) {
                  if (state is SalesChartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SalesChartSuccess) {
                    return SalesChartSection(
                      chartData: state.data,
                      selectedFilter: state.selectedFilter,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              SizedBox(height: 24.h),
              BlocProvider(
                create: (context) =>
                getIt<LowStockCubit>()..getLowStock(),
                child: BlocBuilder<LowStockCubit, LowStockState>(
                  builder: (context, state) {
                    if (state is LowStockLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is LowStockSuccess) {
                      return LowStockSection(products: state.data);
                    }

                    if (state is LowStockError) {
                      return Text(state.message);
                    }

                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 24.h),
              BlocProvider(
                create: (context) =>
                getIt<LatestSupportTicketCubit>()..getLatestTicket(),
                child: BlocBuilder<LatestSupportTicketCubit,
                    LatestSupportTicketState>(
                  builder: (context, state) {
                    if (state is LatestSupportTicketSuccess &&
                        state.ticket != null) {
                      return LatestSupportTicketSection(
                        ticket: state.ticket!,
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              SizedBox(height: 24.h),

            ],
          ),
        ),
      ),
    );
  }
}