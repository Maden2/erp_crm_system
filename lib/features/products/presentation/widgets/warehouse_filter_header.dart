import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class WarehouseFilterHeader extends StatelessWidget {
  final String selectedWarehouseName;
  final VoidCallback? onWarehouseTap;
  final VoidCallback? onSettingsTap;

  const WarehouseFilterHeader({
    super.key,
    required this.selectedWarehouseName,
    this.onWarehouseTap,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: Color(0xFFF6F9FF),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: InkWell(
                onTap: onWarehouseTap,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.categoryIcon,
                        width: 17.w,
                        height: 17.h,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          selectedWarehouseName,
                          style: TextStyles.font13darkOliveGreyRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp,
                        color: AppColors.darkOliveGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 1.w, color: const Color(0xFFD9D9D9)),
            InkWell(
              onTap: onSettingsTap,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Icon(
                  Icons.settings_outlined,
                  size: 22.sp,
                  color: AppColors.darkOliveGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
