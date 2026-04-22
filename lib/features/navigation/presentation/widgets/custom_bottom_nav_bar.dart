import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/utils/app_assets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,




        selectedLabelStyle: TextStyles.fontNavSelected,
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontFamily: 'Cairo',
        ),

        items: [
          _buildNavItem(
            imagePath: AppAssets.homeUnselected,
            activeImagePath: AppAssets.homeSelected,
            label: "الرئيسية",
          ),
          _buildNavItem(
            imagePath: AppAssets.productsUnselected,
            activeImagePath: AppAssets.productsSelected,
            label: "المنتجات",
          ),
          _buildNavItem(
            imagePath: AppAssets.ordersUnselected,
            activeImagePath: AppAssets.ordersSelected,
            label: "الطلبات",
          ),
          _buildNavItem(
            imagePath: AppAssets.analyticsUnselected,
            activeImagePath: AppAssets.analyticsSelected,
            label: "التحليلات",
          ),
          _buildNavItem(
            imagePath: AppAssets.moreUnselected,
            activeImagePath: AppAssets.moreSelected,
            label: "المزيد",
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String imagePath,
    required String activeImagePath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Image.asset(
          imagePath,
          width: 24.w,
          height: 24.h,
        ),
      ),
      activeIcon: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Image.asset(
          activeImagePath,
          width: 24.w,
          height: 24.h,
        ),
      ),
      label: label,
    );
  }
}