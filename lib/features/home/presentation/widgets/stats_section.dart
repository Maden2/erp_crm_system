import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/kpi_entity.dart';
import '../../domain/entities/profit_entity.dart';
import 'stats_card.dart';

class StatsSection extends StatefulWidget {
  final KpiEntity kpi;
  final ProfitEntity profit;

  const StatsSection({
    super.key,
    required this.kpi,
    required this.profit,
  });

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  int currentIndex = 0;
  Timer? _timer;
  static const int _totalCards = 4;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) {
        if (!_controller.hasClients) return;
        final nextPage = (currentIndex + 1) % _totalCards;
        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🟢 لقطة ذكية: التأكد من النسب وحسابها بدقة لتجنب السالب الثابت
    final double todayPct = widget.kpi.todayVsYesterdayPct.toDouble();
    final double monthPct = widget.kpi.monthVsLastMonthPct.toDouble();

    return Column(
      children: [
        SizedBox(
          height: 120.h,
          child: PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              StatsCard(
                title: 'إجمالي مبيعات اليوم',
                value: widget.kpi.todaySales.toString(),
                // 🟢 إظهار القيمة المطلقة للنسبة
                percentage: '${todayPct.abs().toStringAsFixed(0)}%',
                subTitlePrefix: todayPct >= 0 ? 'زيادة بنسبة ' : 'انخفاض بنسبة ',
                subTitleSuffix: ' عن أمس',
                icon: AppAssets.salesIcon,
                iconBgColor: const Color(0xFFE3F2FD),
              ),
              StatsCard(
                title: 'إجمالي مبيعات هذا الشهر',
                value: widget.kpi.monthlySales.toString(),
                percentage: '${monthPct.abs().toStringAsFixed(0)}%',
                subTitlePrefix: monthPct >= 0 ? 'زيادة بنسبة ' : 'انخفاض بنسبة ',
                subTitleSuffix: ' عن الشهر السابق',
                icon: AppAssets.profitsIcon,
                iconBgColor: const Color(0xFFE8F5E9),
              ),
              StatsCard(
                title: 'عدد الطلبات الجديدة',
                value: widget.kpi.todayOrdersCount.toString(),
                percentage: '${widget.kpi.newOrdersLastHour}',
                subTitlePrefix: 'تم تسجيل ',
                subTitleSuffix: ' طلب آخر ساعة',
                icon: AppAssets.ordersIcon,
                iconBgColor: const Color(0xFFFFF3E0),
              ),
              StatsCard(
                title: 'الأرباح الصافية',
                value: widget.profit.monthlyProfit.toString(),
                percentage: '${widget.profit.profitMarginPct.toStringAsFixed(0)}%',
                subTitlePrefix: 'هامش ربح ',
                subTitleSuffix: ' هذا الشهر',
                icon: AppAssets.reportsIcon,
                iconBgColor: const Color(0x2E4170F1),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        SmoothPageIndicator(
          controller: _controller,
          count: _totalCards,
          effect: WormEffect(
            dotHeight: 6.h,
            dotWidth: 6.w,
            spacing: 6.w,
            activeDotColor: AppColors.statsActiveDotColor,
            dotColor: AppColors.statsDotColor,
          ),
        ),
      ],
    );
  }
}