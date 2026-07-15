import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../domain/entities/complaint_entities.dart';

class ComplaintDetailInfoCard extends StatelessWidget {
  final ComplaintItemEntity complaint;

  const ComplaintDetailInfoCard({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = complaint.statusLabel == "مفتوحة";

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      // 🟢 نفس البنية اللي ظبطناها في ComplaintCard (Row بـ textDirection.ltr يضمن نفس المحاذاة)
      // بس من غير الأيقونة والـ SizedBox بتاعتها خالص
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🟢 الاسم والتاريخ في نفس السطر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      complaint.customerName,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    Text(
                      complaint.date,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  complaint.title,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 2.h,
                  ),
                  decoration: BoxDecoration(
                    color: isOpen
                        ? const Color(0xFFFFFBEB)
                        : const Color(0xFFECFDF5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    complaint.statusLabel,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10.sp,
                      color: isOpen
                          ? const Color(0xFFD97706)
                          : const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
