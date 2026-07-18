import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../manager/ticket_cubit.dart';
import '../manager/ticket_state.dart';
import '../widgets/complaints_kpi_header.dart';
import '../widgets/complaint_card.dart';
import '../widgets/complaint_filter_sheet.dart';
import 'complaint_details_page.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TicketCubit>()..fetchTickets(),
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("الشكاوي", style: TextStyles.font20WhiteMedium),
          actions: [
            Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.tune, color: Colors.white),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => ComplaintFilterSheet(
                          ticketCubit: BlocProvider.of<TicketCubit>(context),
                        ),
                      );
                    },
                  );
                }
            ),
          ],
        ),
        body: BlocBuilder<TicketCubit, TicketState>(
          builder: (context, state) {
            if (state is TicketLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is TicketSuccess) {
              final list = state.tickets ?? [];
              final stats = state.stats;

              return Column(
                children: [
                  ComplaintsKpiHeader(
                    total: stats?.totalComplaints ?? 0,
                    open: stats?.openComplaints ?? 0,
                    closed: stats?.closedComplaints ?? 0,
                    rate: stats?.activePercentage ?? "0%",
                  ),
                  Expanded(
                    child: list.isEmpty
                        ? const Center(
                      child: Text(
                        "لا توجد شكاوى حالياً",
                        style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final comp = list[index];
                        return ComplaintCard(
                          complaint: comp,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ComplaintDetailsPage(complaintId: comp.id),
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
            if (state is TicketError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontFamily: 'Cairo', color: Colors.red),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}