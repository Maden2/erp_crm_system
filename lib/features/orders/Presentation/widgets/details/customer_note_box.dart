import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class CustomerNoteBox extends StatelessWidget {
  final String note;
  const CustomerNoteBox({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ملاحظات للموظفين",
            style: TextStyles.font12darkTextMedium,
          ),
          SizedBox(height: 10.h),
          Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: 80.h),
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.authBgColor,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Text(
              note,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyles.font12darkTextMedium
            ),
          ),          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE5E7EB).withOpacity(0.5),
                foregroundColor: const Color(0xFF111827),
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),

                ),
              ),
              child: Text(
                "حفظ الملاحظات",
                style: TextStyles.font12darkTextMedium
              ),
            ),
          ),
        ],
      ),
    );
  }
}