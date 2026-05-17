import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/analytics_entity.dart';
import '../manager/analytics_cubit.dart';
import '../manager/analytics_state.dart';

class SalesSummaryCard extends StatefulWidget {
  const SalesSummaryCard({super.key});

  @override
  State<SalesSummaryCard> createState() => _SalesSummaryCardState();
}

class _SalesSummaryCardState extends State<SalesSummaryCard> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.80,
  );

  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;
      int nextPage = (_currentIndex + 1) % 4;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _buildCards(AnalyticsEntity data) {
    return [
      {
        'title': 'إجمالي مبيعات اليوم',
        'value': '${data.totalSalesToday.toStringAsFixed(0)} ج.م',
        'percent': '${data.salesChangePercentage >= 0 ? '+' : ''}${data.salesChangePercentage}%',
        'isPositive': data.salesChangePercentage >= 0,
        'iconColor': const Color(0xFF1D4ED8),
        'icon': Icons.trending_up,
        'chartColor': const Color(0xFF1D4ED8),
        'spots': data.salesChart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
      },
      {
        'title': 'الأرباح الصافية',
        'value': '${data.netProfit.toStringAsFixed(0)} ج.م',
        'percent': '${data.netProfitChangePercentage >= 0 ? '+' : ''}${data.netProfitChangePercentage}%',
        'isPositive': data.netProfitChangePercentage >= 0,
        'iconColor': const Color(0xFF10B981),
        'icon': Icons.account_balance_wallet_outlined,
        'chartColor': const Color(0xFF10B981),
        'spots': data.netProfitChart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
      },
      {
        'title': 'عدد الطلبات',
        'value': data.totalOrders.toString(),
        'percent': '${data.ordersChangePercentage >= 0 ? '+' : ''}${data.ordersChangePercentage}%',
        'isPositive': data.ordersChangePercentage >= 0,
        'iconColor': const Color(0xFF7C3AED),
        'icon': Icons.shopping_cart_outlined,
        'chartColor': const Color(0xFF3B82F6),
        'spots': data.ordersChart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
      },
      {
        'title': 'نسبة الإلغاءات',
        'value': '${data.cancellationRate}%',
        'percent': '${data.cancellationChangePercentage >= 0 ? '+' : ''}${data.cancellationChangePercentage}%',
        'isPositive': data.cancellationChangePercentage >= 0,
        'iconColor': const Color(0xFFF59E0B),
        'icon': Icons.warning_amber_rounded,
        'chartColor': const Color(0xFFF59E0B),
        'spots': data.cancellationChart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        if (state is AnalyticsLoading) {
          return SizedBox(height: 160.h, child: const Center(child: CircularProgressIndicator()));
        }

        if (state is AnalyticsSuccess) {
          final cards = _buildCards(state.analytics);
          return Column(
            children: [
              SizedBox(
                height: 117.h,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: PageView.builder(
                    controller: _pageController,
                    reverse: false,
                    itemCount: cards.length,
                    onPageChanged: (i) => setState(() => _currentIndex = i),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          right: index == 0 ? 0 : 8.w,
                          left: index == cards.length - 1 ? 0 : 8.w,
                        ),
                        child: _buildCard(cards[index]),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              SmoothPageIndicator(
                controller: _pageController,
                count: cards.length,
                effect: WormEffect(
                  dotHeight: 6.h,
                  dotWidth: 6.w,
                  activeDotColor: AppColors.statsActiveDotColor,
                  dotColor: AppColors.statsDotColor,
                  spacing: 6.w,
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCard(Map<String, dynamic> card) {
    final chartColor = card['chartColor'] as Color;
    final isPositive = card['isPositive'] as bool;

    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: card['iconColor'] as Color,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(card['icon'] as IconData, color: Colors.white, size: 14.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          card['title'],
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10.sp,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          card['percent'],
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: isPositive
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      card['value'],
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: card['spots'] as List<FlSpot>,
                    isCurved: true,
                    color: chartColor,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [chartColor.withOpacity(0.12), chartColor.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                minX: 0,
                maxX: (card['spots'] as List<FlSpot>).length.toDouble() - 1,
                minY: 0,
                maxY: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}