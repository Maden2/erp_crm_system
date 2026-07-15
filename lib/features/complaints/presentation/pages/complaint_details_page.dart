import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/complaints_cubit.dart';
import '../manager/complaints_state.dart';

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
      create: (_) =>
      getIt<ComplaintsCubit>()..fetchComplaintDetails(complaintId),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          // 🟢 شلت الزرار الأسود الافتراضي (اللي بيظهر أوتوماتيك) وسبت بس الأبيض المخصص في actions
          leading:IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ) ,
          title: Text(
            "تفاصيل الشكوى",
            style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
          ),

        ),
        body: BlocBuilder<ComplaintsCubit, ComplaintsState>(
          builder: (context, state) {
            if (state is ComplaintsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (state is ComplaintsSuccess && state.selectedDetail != null) {
              final d = state.selectedDetail!;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    // 1️⃣ كارت معلومات الحالة
                    ComplaintDetailInfoCard(complaint: d.infoCard),
                    SizedBox(height: 12.h),

                    // 2️⃣ كارت نص الشكوى
                    ComplaintDetailTextCard(description: d.fullDescription),
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}