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
      color: Colors.transparent, //[cite: 15]
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h), //[cite: 15]
      child: Container(
        height: 48.h, //[cite: 15]
        decoration: BoxDecoration(
          color: const Color(0xFFF6F9FF), //[cite: 15]
          borderRadius: BorderRadius.circular(8.r), //[cite: 15]
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.w), //[cite: 15]
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, //[cite: 15]
          children: [
            Expanded(
              child: InkWell(
                onTap: onWarehouseTap, //[cite: 15]
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r), //[cite: 15]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w), //[cite: 15]
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.categoryIcon, //[cite: 15]
                        width: 17.w, //[cite: 15]
                        height: 17.h, //[cite: 15]
                      ),
                      SizedBox(width: 8.w), //[cite: 15]
                      Expanded(
                        child: Text(
                          selectedWarehouseName, //[cite: 15]
                          style: TextStyles.font13darkOliveGreyRegular, //[cite: 15]
                          overflow: TextOverflow.ellipsis, //[cite: 15]
                        ),
                      ),
                      SizedBox(width: 6.w), //[cite: 15]
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 20.sp, //[cite: 15]
                        color: AppColors.darkOliveGrey, //[cite: 15]
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(width: 1.w, color: const Color(0xFFD9D9D9)), //[cite: 15]
            InkWell(
              onTap: onSettingsTap, //[cite: 15]
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r), //[cite: 15]
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w), //[cite: 15]
                child: Icon(
                  Icons.settings_outlined,
                  size: 22.sp, //[cite: 15]
                  color: AppColors.darkOliveGrey, //[cite: 15]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}