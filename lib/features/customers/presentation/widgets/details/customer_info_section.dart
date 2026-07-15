import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class CustomerInfoSection extends StatelessWidget {
  final String phone;
  final String email;
  final String regDate;
  final String deliveryNotes;
  final double? rating;

  const CustomerInfoSection({
    super.key,
    required this.phone,
    required this.email,
    required this.regDate,
    required this.deliveryNotes,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "معلومات العميل",
                style: TextStyles.font16graphiteGreyMedium.copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (rating != null) _buildRating(),
            ],
          ),
          SizedBox(height: 18.h),
          _buildInfoRow(
            iconAsset: AppAssets.phoneIcon,
            title: "رقم الهاتف",
            value: phone,
          ),
          _buildDivider(),
          _buildInfoRow(
            iconAsset: AppAssets.mailIcon,
            title: "البريد الإلكتروني",
            value: email,
          ),
          _buildDivider(),
          _buildInfoRow(
            iconAsset: AppAssets.dateIcon,
            title: "تاريخ التسجيل",
            value: regDate,
          ),
          if (deliveryNotes.isNotEmpty) ...[
            SizedBox(height: 18.h),
            _buildNoteBox(deliveryNotes),
          ],
        ],
      ),
    );
  }

  Widget _buildSvgIcon(String assetPath, {double? size, Color? color}) {
    return SvgPicture.asset(
      assetPath,
      width: size ?? 18.sp,
      height: size ?? 18.sp,
      colorFilter: ColorFilter.mode(
        color ?? AppColors.lightGrayText,
        BlendMode.srcIn,
      ),
    );
  }

  Widget _buildInfoRow({
    required String iconAsset,
    required String title,
    required String value,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      textDirection: TextDirection.rtl,
      children: [
        _buildSvgIcon(iconAsset),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.font10lightGrayTextRegular,
            ),
            SizedBox(height: 3.h),
            Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyles.font12BlackRegular.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: const Divider(
        color: Color(0xFFF1F5F9),
        height: 1,
      ),
    );
  }

  Widget _buildRating() {
    final filledStars = rating!.floor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "   تقييم العميل ${rating!.toStringAsFixed(1)}",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lightGrayText,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: List.generate(
            5,
                (index) => Padding(
              padding: EdgeInsets.only(left: 2.w),
              child: Icon(
                index < filledStars ? Icons.star_rounded : Icons.star_border_rounded,
                color: const Color(0xFFFBBF24),
                size: 15.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoteBox(String note) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFFEF3C7)),
      ),
      child: IntrinsicHeight(
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFBBF24),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  bottomRight: Radius.circular(8.r),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          AppAssets.noteIcon,
                          width: 14.w,
                          height: 14.h,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFD97706),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "ملاحظة العميل",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      note,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11.sp,
                        height: 1.4,
                        color: const Color(0xFF783533),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}