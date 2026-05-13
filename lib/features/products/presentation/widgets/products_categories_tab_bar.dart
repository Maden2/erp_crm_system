import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';

class ProductsCategoriesTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;
  final Function(int)? onTap;

  const ProductsCategoriesTabBar({
    super.key,
    required this.tabController,
    required this.tabs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: TabBar(
        controller: tabController,
        isScrollable: true,
        onTap: onTap,
        tabAlignment: TabAlignment.start,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.lightGrayText,
        indicatorColor: AppColors.primary,
        indicatorWeight: 2.5,
        dividerColor: Colors.transparent,
        labelStyle: TextStyle(
            fontSize: 12.sp,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700
        ),
        tabs: tabs.map((e) => Tab(
          child: Text(e, overflow: TextOverflow.ellipsis),
        )).toList(),
      ),
    );
  }
}