import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pivot/core/utils/app_assets.dart';
import 'package:pivot/core/utils/app_colors.dart';

class NotificationSettingsCard extends StatefulWidget {
  const NotificationSettingsCard({super.key});

  @override
  State<NotificationSettingsCard> createState() => _NotificationSettingsCardState();
}

class _NotificationSettingsCardState extends State<NotificationSettingsCard> {
  bool newOrders = true;
  bool lowStock = true;
  bool techSupport = false;
  bool systemUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Color(0x1A0052B5),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppAssets.settingsNotificationIcon,
                  colorFilter: const ColorFilter.mode(Color(0xFF3B82F6), BlendMode.srcIn),
                ),
              ),

              SizedBox(width: 6.w),
              Text(
                "إعدادات الإشعارات",
                style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w500, color: Color(0xFF111827)),
              ),

              // 🟢 كونتينر دائري مثالي للأيقونة الـ SVG
            ],
          ),
          SizedBox(height: 12.h),
          _buildSwitchRow("طلبات جديدة", newOrders, (val) => setState(() => newOrders = val)),
          SizedBox(height: 10.h),
          _buildSwitchRow("مخزون منخفض", lowStock, (val) => setState(() => lowStock = val)),
          SizedBox(height: 10.h),
          _buildSwitchRow("دعم فني", techSupport, (val) => setState(() => techSupport = val)),
          SizedBox(height: 10.h),
          _buildSwitchRow("تحديثات النظام", systemUpdates, (val) => setState(() => systemUpdates = val)),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(String title, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontFamily: 'Cairo', fontWeight: FontWeight.w400,fontSize: 10.sp, color: const Color(0xFF313131)),
        ),

        Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF0052B5),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: const Color(0xFFE9E9EA),
            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}