import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../domain/entities/full_analytics_entity.dart';
import '../manager/full_analytics_cubit.dart';
import '../manager/full_analytics_state.dart';

class SalesSummaryCard extends StatefulWidget {
  const SalesSummaryCard({super.key});

  @override
  State<SalesSummaryCard> createState() => _SalesSummaryCardState();
}

class _SalesSummaryCardState extends State<SalesSummaryCard> {
  final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
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
      int nextPage = (_currentIndex + 1) % 3;
      _pageController.animateToPage(nextPage, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _buildCards(FullAnalyticsEntity data) {
    final revenue = data.overview.revenue;
    final orders = data.overview.orders;
    final aov = data.overview.averageOrderValue;

    List<FlSpot> chartSpots = data.salesChart.chart.isEmpty
        ? [const FlSpot(0, 0)]
        : data.salesChart.chart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.revenue)).toList();

    return [
      {
        'title': 'إجمالي مبيعات اليوم',
        'value': '${revenue.current.toStringAsFixed(0)} ج.م',
        'percent': revenue.changePercent != null ? '${revenue.changePercent >= 0 ? '+' : ''}${revenue.changePercent}%' : '0.0%',
        'isPositive': revenue.trend == 'up',
        'iconColor': const Color(0xFF1D4ED8),
        'icon': Icons.trending_up,
        'spots': chartSpots,
      },
      {
        'title': 'عدد الطلبات',
        'value': orders.current.toString(),
        'percent': orders.changePercent != null ? '${orders.changePercent >= 0 ? '+' : ''}${orders.changePercent}%' : '0.0%',
        'isPositive': orders.trend == 'up',
        'iconColor': const Color(0xFF7C3AED),
        'icon': Icons.shopping_cart_outlined,
        'spots': data.salesChart.chart.isEmpty
            ? [const FlSpot(0, 0)]
            : data.salesChart.chart.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.ordersCount.toDouble())).toList(),
      },
      {
        'title': 'متوسط قيمة الطلب (AOV)',
        'value': '${aov.current.toStringAsFixed(0)} ج.م',
        'percent': aov.changePercent != null ? '${aov.changePercent >= 0 ? '+' : ''}${aov.changePercent}%' : '0.0%',
        'isPositive': aov.trend == 'up',
        'iconColor': const Color(0xFF10B981),
        'icon': Icons.analytics_outlined,
        'spots': chartSpots,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FullAnalyticsCubit, FullAnalyticsState>(
      builder: (context, state) {
        if (state is FullAnalyticsSuccess) {
          final cards = _buildCards(state.analytics);
          return Column(
            children: [
              SizedBox(
                height: 120.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  onPageChanged: (i) => setState(() => _currentIndex = i),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      child: _buildCard(cards[index]),
                    );
                  },
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
    final isPositive = card['isPositive'] as bool;
    final List<FlSpot> spots = card['spots'] as List<FlSpot>;
    final Color accentColor = card['iconColor'] as Color;

    // 🟢 حساب ديناميكي مأمن للحدود لمنع الميلة الحادة أو النزول الحاد بره المربع
    double minY = spots.isEmpty ? 0 : spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    double maxY = spots.isEmpty ? 10 : spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);

    double verticalPadding = (maxY - minY) * 0.25;
    if (verticalPadding == 0) verticalPadding = 2.0; // حالة الأمان إذا كانت القيم متطابقة أو أصفار

    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(color: accentColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8.r)),
                child: Icon(card['icon'] as IconData, color: accentColor, size: 16.sp),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(card['title'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: const Color(0xFF64748B))),
                        Text(card['percent'], style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, fontWeight: FontWeight.w600, color: isPositive ? const Color(0xFF22C55E) : const Color(0xFFEF4444))),
                      ],
                    ),
                    Text(card['value'], style: TextStyle(fontFamily: 'Cairo', fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E293B))),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            height: 32.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: accentColor,
                    barWidth: 2,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [accentColor.withOpacity(0.15), accentColor.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                minX: 0,
                maxX: spots.length.toDouble() - 1,
                // 🟢 إجبار الشارت على التموضع داخل حدود متزنة
                minY: minY - verticalPadding,
                maxY: maxY + verticalPadding,
              ),
            ),
          ),
        ],
      ),
    );
  }
}