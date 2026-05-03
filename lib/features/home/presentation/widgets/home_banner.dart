import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_styles.dart';
import '../../domain/entities/home_banner_entity.dart';

class HomeBanner extends StatefulWidget {
  final HomeBannerEntity? data;

  const HomeBanner({super.key, this.data});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer _timer;


  late final HomeBannerEntity _dummyData = HomeBannerEntity(
    userName: "محمد",
    orderNumber: "2483",
  );

  HomeBannerEntity get data => widget.data ?? _dummyData;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage > 2) _currentPage = 0;

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
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
        SizedBox(
          height: 100.h,
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _buildBannerItem(
                image: AppAssets.welcomeBannerBg,
                title: "أهلاً ${data.userName} 👋",
                subtitle:
                "لنبدأ رحلتك في تنظيم عملك… كل شيء جاهز للانطلاق!",
              ),
              _buildBannerItem(
                image: AppAssets.ordersBannerBg,
                title:
                "تم استلام طلب جديد رقم #${data.orderNumber}",
                hasIcon: true,
                iconPath: AppAssets.alarmIcon,
              ),
              _buildBannerItem(
                image: AppAssets.paymentsBannerBg,
                title: "تم تسجيل عملية دفع معلّقة",
                hasIcon: true,
                iconPath: AppAssets.walletIcon,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.h,
          child: SmoothPageIndicator(
            controller: _pageController,
            count: 3,
            effect: WormEffect(
              dotHeight: 6.h,
              dotWidth: 6.w,
              activeDotColor: AppColors.activeDotColor,
              dotColor: AppColors.grey,
              spacing: 4.w,
              type: WormType.thin,
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
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Row(
          children: [
            if (hasIcon && iconPath != null) ...[
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Image.asset(
                  iconPath,
                  width: 24.w,
                  height: 24.h,
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title != null)
                    Text(title, style: TextStyles.font16WhiteBold),
                  if (subtitle != null) ...[
                    SizedBox(height: 8.h),
                    Text(subtitle,
                        style: TextStyles.font12WhiteRegular),
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