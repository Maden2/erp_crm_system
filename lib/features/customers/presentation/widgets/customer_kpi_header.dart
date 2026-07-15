import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class KpiCardData {
  final String title;
  final String value;
  final String subTitle;
  final Color textColor;
  final Color bgColor;
  final bool isPositiveTrend;

  const KpiCardData({
    required this.title,
    required this.value,
    required this.subTitle,
    required this.textColor,
    required this.bgColor,
    this.isPositiveTrend = true,
  });
}

class CustomerKpiHeader extends StatefulWidget {
  final int totalCount;
  final int activeCount;
  final String activePercentage; // 🟢 استقبال النسبة المئوية مباشرة من السيرفر

  final String? topSpenderName;
  final num? topSpenderAmount;
  final List<KpiCardData> extraCards;

  const CustomerKpiHeader({
    super.key,
    required this.totalCount,
    required this.activeCount,
    required this.activePercentage, // 🟢 تم تفعيلها هنا
    this.topSpenderName,
    this.topSpenderAmount,
    this.extraCards = const [],
  });

  @override
  State<CustomerKpiHeader> createState() => _CustomerKpiHeaderState();
}

class _CustomerKpiHeaderState extends State<CustomerKpiHeader> {
  late final PageController _pageController;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_pageController.hasClients) return;

      final pagesCount = _pages.length;
      if (pagesCount <= 1) return;

      final nextPage = (_currentPage + 1) % pagesCount;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<KpiCardData> get _allCards {
    return [
      KpiCardData(
        title: "عملاء نشطون",
        value: "${widget.activeCount}",
        subTitle: widget.activePercentage, // 🟢 النسبة الحقيقية اللايف من السيرفر
        textColor: const Color(0xFF10B981),
        bgColor: const Color(0xFFECFDF5),
        isPositiveTrend: true,
      ),
      KpiCardData(
        title: "إجمالي العملاء",
        value: "${widget.totalCount}",
        subTitle: "+8%",
        textColor: const Color(0xFF2563EB),
        bgColor: const Color(0xFFEFF6FF),
        isPositiveTrend: true,
      ),
      KpiCardData(
        title: "أعلى عميل إنفاقاً",
        value: widget.topSpenderName ?? "—",
        subTitle: widget.topSpenderAmount != null
            ? "${widget.topSpenderAmount} ج.م"
            : "لا يوجد بيانات",
        textColor: const Color(0xFFF59E0B),
        bgColor: const Color(0xFFFFFBEB),
        isPositiveTrend: true,
      ),
      ...widget.extraCards,
    ];
  }

  List<List<KpiCardData>> get _pages {
    final cards = _allCards;
    final pages = <List<KpiCardData>>[];
    for (var i = 0; i < cards.length; i += 2) {
      pages.add(cards.sublist(i, i + 2 > cards.length ? cards.length : i + 2));
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _pages;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 4.h),
      child: Column(
        children: [
          SizedBox(
            height: 120.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                _currentPage = index;
              },
              itemBuilder: (context, pageIndex) {
                final pageCards = pages[pageIndex];
                return Row(
                  children: [
                    for (int i = 0; i < pageCards.length; i++) ...[
                      if (i != 0) SizedBox(width: 10.w),
                      Expanded(child: _buildKpiCard(pageCards[i])),
                    ],
                    if (pageCards.length == 1) const Spacer(),
                  ],
                );
              },
            ),
          ),

          if (pages.length > 1) ...[
            SizedBox(height: 8.h),
            SmoothPageIndicator(
              controller: _pageController,
              count: pages.length,
              effect: WormEffect(
                dotHeight: 6.h,
                dotWidth: 6.w,
                spacing: 6.w,
                activeDotColor: AppColors.statsActiveDotColor,
                dotColor: AppColors.statsDotColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildKpiCard(KpiCardData data) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0x0A000000),
            blurRadius: 6,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            data.title,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            data.value,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            data.subTitle,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2563EB),
            ),
          ),
        ],
      ),
    );
  }
}