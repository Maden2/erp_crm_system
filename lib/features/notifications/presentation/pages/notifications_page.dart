import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/notice_cubit.dart';
import '../manager/notice_state.dart';
import '../widgets/notification_item_card.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NoticeCubit>()..fetchNotices(), // 🟢 الربط بالكيوبيت الجديد الحقيقي المربوط بالسيرفر
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          // 1️⃣ على الشمال زر تحديد الكل كمقروء لايف
          leadingWidth: 150.w,
          leading: BlocBuilder<NoticeCubit, NoticeState>(
            builder: (context, state) {
              return TextButton.icon(
                onPressed: () {
                  context.read<NoticeCubit>().markAllAsRead(); // 🟢 تشغيل الأكشن الحقيقي لتحديث الكل كمقروء
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
        body: BlocBuilder<NoticeCubit, NoticeState>(
          builder: (context, state) {
            if (state is NoticeLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }

            if (state is NoticeSuccess) {
              final notificationsList = state.notices;

              if (notificationsList.isEmpty) {
                return const Center(
                  child: Text(
                    "لا توجد إشعارات حالياً",
                    style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                itemCount: notificationsList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = notificationsList[index];
                  return NotificationItemCard(
                    notification: item,
                    onTap: () {
                      if (!item.isRead) {
                        context.read<NoticeCubit>().markAsRead(item.id); // 🟢 قراءة الإشعار المفرد عند الضغط عليه
                      }
                    },
                  );
                },
              );
            }

            if (state is NoticeError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}