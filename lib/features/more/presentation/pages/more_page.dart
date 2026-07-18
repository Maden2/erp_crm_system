import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../auth/presentation/manager/auth_cubit.dart';
import '../../../auth/presentation/manager/auth_state.dart';
import '../widgets/menu_tile.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.login,
                  (route) => false,
            );
          }

          if (state is LogoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),
                _buildCompanyHeader(),
                SizedBox(height: 24.h),

                _buildSectionTitle("الإدارة المالية"),
                MenuTile(
                  title: "الفواتير",
                  subtitle: "ادارة وعرض الفواتير",
                  icon: AppAssets.invoicesIcon,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.invoicesPage);
                  },
                ),
                /*  MenuTile(
                  title: "الأرباح",
                  subtitle: "تحليل الأرباح وصافي الدخل",
                  icon: AppAssets.profitsMoreIcon,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profitsPage);
                  },
                ),*/

                SizedBox(height: 16.h),
                _buildSectionTitle("العمليات"),
                /* MenuTile(
                  title: "المخزون",
                  subtitle: "متابعة الكميات والتنببهات",
                  icon: AppAssets.inventoryIcon,
                  onTap: () {},
                ), */
                MenuTile(
                  title: "العملاء",
                  subtitle: "بيانات وسجل العملاء",
                  icon: AppAssets.customersIcon,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.customersPage);
                  },
                ),

                SizedBox(height: 16.h),
                _buildSectionTitle("الدعم والجودة"),
                MenuTile(
                  title: "الشكاوي",
                  subtitle: "إدارة الشكاوي الواردة",
                  icon: AppAssets.complaintsIcon,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.complaintsPage);
                  },
                ),

                SizedBox(height: 16.h),
                _buildSectionTitle("التخصيص والنظام"),
                MenuTile(
                  title: "الأشعارات",
                  subtitle: "تنبيهات النظام",
                  icon: AppAssets.notificationsIcon,
                  onTap: () {
                    Navigator.pushNamed(context, Routes.notificationsPage);
                  },
                ),

                SizedBox(height: 16.h),
                _buildSectionTitle("الإعدادات"),
              /*  MenuTile(
                  title: "الاعدادات",
                  subtitle: "الحساب، اللغة، الدفع",
                  icon: AppAssets.settingsIcon,
                  // 🟢 تم ربط شاشة الإعدادات الجديدة بمسار الـ Routes الحقيقي بالملي
                  onTap: () {
                    Navigator.pushNamed(context, Routes.settingsPage);
                  },
                ), */

                _buildLogoutButton(),

                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, right: 4.w),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF313131),
        ),
      ),
    );
  }

  Widget _buildCompanyHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Container(
            padding: EdgeInsets.all(12.5.w),
            decoration: const BoxDecoration(
              color: AppColors.homeBg,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.companyIcon,
              width: 24.sp,
              height: 24.sp,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الشركة اليابانية",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                "نشط",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 11.sp,
                  color: Colors.greenAccent,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.homeBg,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return MenuTile(
          title: "تسجيل الخروج",
          icon: AppAssets.logoutIcon,
          textColor: const Color(0xFFEF4444),
          iconContainerColor: AppColors.redColor,
          isLoading: state is LogoutLoading,
          onTap: () {
            context.read<AuthCubit>().logout();
          },
        );
      },
    );
  }
}