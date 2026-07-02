import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/greeting_entity.dart';

class HomeBanner extends StatefulWidget {
  final GreetingEntity greeting;

  const HomeBanner({
    super.key,
    required this.greeting,
  });

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
          (timer) {
        if (!_pageController.hasClients) return;
        _currentPage++;
        if (_currentPage > 2) {
          _currentPage = 0;
        }
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 3.2,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildBannerItem(
                image: AppAssets.welcomeBannerBg,
                title: "أهلاً ${widget.greeting.fullName} 👋",
                subtitle: widget.greeting.message,
              ),
              _buildBannerItem(
                image: AppAssets.ordersBannerBg,
                title: "تابع لوحة التحكم لمتابعة آخر الطلبات الحالية",
                hasIcon: true,
                iconPath: AppAssets.alarmIcon,
              ),
              _buildBannerItem(
                image: AppAssets.paymentsBannerBg,
                title: "مبيعاتك وأرباحك محدثة لحظياً من السيرفر",
                hasIcon: true,
                iconPath: AppAssets.walletIcon,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 8.h,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 6.h,
              dotWidth: 6.w,
              spacing: 4.w,
              type: WormType.thin,
              activeDotColor: AppColors.activeDotColor,
              dotColor: AppColors.grey,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBannerItem({
    required String image,
    String? title,
    String? subtitle,
    bool hasIcon = false,
    String? iconPath,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        child: Row(
          children: [
            if (hasIcon && iconPath != null) ...[
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Image.asset(iconPath, width: 24.w, height: 24.h),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null)
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font16WhiteBold,
                    ),
                  if (subtitle != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font12WhiteRegular,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}