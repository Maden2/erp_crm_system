import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/notifications_cubit.dart';
import '../manager/notifications_state.dart';
import '../widgets/notification_item_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit()..fetchNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          // 1️⃣ على الشمال زر تحديد الكل كمقروء
          leadingWidth: 150.w,
          leading: BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              return TextButton.icon(
                onPressed: () {
                  // هنا هنربط الأكشن بعدين لتحديث الحالة
                },
                icon: const Icon(Icons.notifications_outlined, size: 14, color: Colors.white70),
                label: Text(
                  "تحديد الكل كمقروء",
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 10.sp, color: Colors.white70),
                ),
              );
            },
          ),
          title: Text("الإشعارات", style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo')),
          // 2️⃣ على اليمين زر الرجوع
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
            if (state is NotificationsSuccess) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                itemCount: state.notifications.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return NotificationItemCard(notification: state.notifications[index]);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}