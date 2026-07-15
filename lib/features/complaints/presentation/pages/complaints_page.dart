import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/complaints_cubit.dart';
import '../manager/complaints_state.dart';
import '../widgets/complaints_kpi_header.dart';
import '../widgets/complaint_card.dart';
import '../widgets/complaint_filter_sheet.dart';
import 'complaint_details_page.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ComplaintsCubit>()..fetchComplaints(),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),

          title: Text("الشكاوي", style: TextStyles.font20WhiteMedium),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune, color: Colors.white),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const ComplaintFilterSheet(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ComplaintsCubit, ComplaintsState>(
          builder: (context, state) {
            if (state is ComplaintsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is ComplaintsSuccess) {
              final list = state.container;
              return Column(
                children: [
                  ComplaintsKpiHeader(
                    total: list.totalCount,
                    open: list.openCount,
                    closed: list.closedCount,
                    rate: list.closeRatePercent,
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: list.complaints.length,
                      itemBuilder: (context, index) {
                        final comp = list.complaints[index];
                        return ComplaintCard(
                          complaint: comp,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ComplaintDetailsPage(complaintId: comp.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
