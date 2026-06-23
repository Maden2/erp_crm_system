import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../domain/entities/home_stats_entity.dart';
import 'stats_card.dart';

class StatsSection extends StatefulWidget {
  final HomeStatsEntity? data;

  const StatsSection({super.key, this.data});

  @override
  State<StatsSection> createState() => _StatsSectionState();
}

class _StatsSectionState extends State<StatsSection> {
  final PageController _controller = PageController(viewportFraction: 0.85);
  int currentIndex = 0;
  Timer? _timer;
  static const int _totalCards = 4;

  late final HomeStatsEntity dummy = HomeStatsEntity(
    salesValue: '24,000',
    salesPercentage: '12%',
    profitsValue: '390,800',
    profitsPercentage: '8%',
    ordersValue: '145',
    ordersPercentage: '20%',
    reportsValue: '90,000',
    reportsPercentage: '25%',
  );

  HomeStatsEntity get data => widget.data ?? dummy;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_controller.hasClients) return;
      final nextPage = (currentIndex + 1) % _totalCards;
      _controller.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 108.h,
          width: 400.w,
          child: PageView(
            controller: _controller,
            onPageChanged: (index) => setState(() => currentIndex = index),
            children: [
              StatsCard(
                title: 'إجمالي مبيعات اليوم',
                value: data.salesValue,
                percentage: data.salesPercentage,
                subTitlePrefix: 'زيادة بنسبة ',
                subTitleSuffix: ' عن أمس',
                icon: AppAssets.salesIcon,
                iconBgColor: const Color(0xFFE3F2FD),
              ),
              StatsCard(
                title: 'إجمالي مبيعات هذا الشهر',
                value: data.profitsValue,
                percentage: data.profitsPercentage,
                subTitlePrefix: 'زيادة بنسبة ',
                subTitleSuffix: ' عن الشهر السابق',
                icon: AppAssets.profitsIcon,
                iconBgColor: const Color(0xFFE8F5E9),
              ),
              StatsCard(
                title: 'عدد الطلبات الجديدة',
                value: data.ordersValue,
                percentage: data.ordersPercentage,
                subTitlePrefix: 'انخفاض بنسبة ',
                subTitleSuffix: ' في آخر ساعة',
                icon: AppAssets.ordersIcon,
                iconBgColor: const Color(0xFFFFF3E0),
              ),
              StatsCard(
                title: 'الأرباح الصافية',
                value: data.reportsValue,
                percentage: data.reportsPercentage,
                subTitlePrefix: 'زيادة بنسبة ',
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
            activeDotColor: AppColors.statsActiveDotColor,
            dotColor: AppColors.statsDotColor,
            spacing: 6.w,
          ),
        ),
      ],
    );
  }
}
