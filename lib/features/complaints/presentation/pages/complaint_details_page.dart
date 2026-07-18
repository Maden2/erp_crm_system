import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/ticket_cubit.dart';
import '../manager/ticket_state.dart';

// Imports للـ Widgets الجديدة من فولدر الـ details
import '../widgets/details/complaint_detail_info_card.dart';
import '../widgets/details/complaint_detail_text_card.dart';
import '../widgets/details/complaint_detail_ticket_summary.dart';

class ComplaintDetailsPage extends StatelessWidget {
  final String complaintId;

  const ComplaintDetailsPage({super.key, required this.complaintId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TicketCubit>()..fetchTicketDetails(complaintId), // 🟢 التوجيه للكيوبيت المعزول الجديد لايف
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "تفاصيل الشكوى",
            style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
          ),
        ),
        body: BlocBuilder<TicketCubit, TicketState>( // 🟢 استخدام الـ TicketCubit والـ TicketState الجداد
          builder: (context, state) {
            if (state is TicketDetailsLoading) { // 🟢 الـ State المخصص لتحميل التفاصيل
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is TicketSuccess && state.selectedTicket != null) {
              final d = state.selectedTicket!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    // 1️⃣ كارت معلومات الحالة المربوط بالـ Entity الجديدة
                    ComplaintDetailInfoCard(complaint: d),
                    SizedBox(height: 12.h),

                    // 2️⃣ كارت نص الشكوى
                    ComplaintDetailTextCard(description: d.complaintText),
                    SizedBox(height: 12.h),

                    // 3️⃣ كارت ملخص التذكرة والجدول
                    ComplaintDetailTicketSummary(
                      orderNumber: d.orderNumber,
                      productName: d.productName,
                      orderDate: d.orderDate,
                    ),
                  ],
                ),
              );
            }

            if (state is TicketError) { // 🟢 هندلة حالة الخطأ عشان الشاشة متبقاش بيضاء لو الـ API علق
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    "حدث خطأ أثناء تحميل التفاصيل: ${state.message}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Cairo', color: Colors.red, fontWeight: FontWeight.bold),
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