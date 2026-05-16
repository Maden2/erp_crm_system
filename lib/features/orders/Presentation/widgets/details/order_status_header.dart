import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../../core/utils/app_assets.dart';
import '../order_status_badge.dart';

class OrderStatusHeader extends StatelessWidget {
  final String status;
  final String date;

  const OrderStatusHeader({
    super.key,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrderStatusBadge(
          status: status,
          showDot: true,
        ),

        Row(
          children: [
            SvgPicture.asset(
              AppAssets.dateIcon,
              width: 12.w,
              height: 12.h,
              colorFilter: const ColorFilter.mode(
                AppColors.greyText,
                BlendMode.srcIn,
              ),
            ),

            SizedBox(width: 4.w),

            Text(
              date,
              style: TextStyles.font10GreyTextRegular
            ),
          ],
        ),
      ],
    );
  }
}