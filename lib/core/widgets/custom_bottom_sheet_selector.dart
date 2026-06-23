import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_styles.dart';

class CustomBottomSheetSelector<T> extends StatelessWidget {
  final String title;
  final String subTitle;
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  const CustomBottomSheetSelector({
    super.key,
    required this.title,
    required this.subTitle,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 18.h),
          Text(title, style: TextStyles.font18DarkBlueBold),
          SizedBox(height: 8.h),
          Text(
            subTitle,
            style: TextStyles.font13darkOliveGreyRegular,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: items.map((item) => itemBuilder(item)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
