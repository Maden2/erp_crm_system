import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';

class OrdersTabBar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTap;

  const OrdersTabBar({super.key, required this.tabs, required this.onTap});

  @override
  State<OrdersTabBar> createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends State<OrdersTabBar> {
  // 🟢 تعديل الـ index المبدئي ليكون 4 (تابة "الكل") ليطابق ريكويست البداية صراحة
  int selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(color: AppColors.homeBg),
        child: Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.authBgColor,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            children: List.generate(widget.tabs.length, (index) {
              bool isSelected = selectedIndex == index;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedIndex = index);
                    widget.onTap(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w), // إضافة padding جانبي لحماية النص
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    // 🟢 إضافة FittedBox لحماية كلمة "قيد الانتظار" الطويلة من البكسلة أو الانضغاط
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.tabs[index],
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12.sp, // تقليل طفيف لضمان التناسق التام
                          color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).reversed.toList(),
          ),
        ),
      ),
    );
  }
}