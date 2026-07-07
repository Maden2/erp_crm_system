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
      width: double.infinity, //[cite: 12]
      color: Colors.transparent, //[cite: 12]
      child: TabBar(
        controller: tabController, //[cite: 12]
        isScrollable: true, //[cite: 12]
        onTap: onTap, //[cite: 12]
        tabAlignment: TabAlignment.start, //[cite: 12]
        labelColor: AppColors.primary, //[cite: 12]
        unselectedLabelColor: AppColors.lightGrayText, //[cite: 12]
        indicatorColor: AppColors.primary, //[cite: 12]
        indicatorWeight: 2.5, //[cite: 12]
        dividerColor: Colors.transparent, //[cite: 12]
        labelStyle: TextStyle(
          fontSize: 12.sp, //[cite: 12]
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700, //[cite: 12]
        ),
        tabs: tabs
            .map((e) => Tab(child: Text(e, overflow: TextOverflow.ellipsis))) //[cite: 12]
            .toList(),
      ),
    );
  }
}