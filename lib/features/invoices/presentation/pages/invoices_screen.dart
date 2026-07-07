import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';
import '../../../../core/utils/app_styles.dart';
import '../manager/full_invoices_cubit.dart';
import '../manager/full_invoices_state.dart';
import '../widgets/empty_invoices_view.dart';
import '../widgets/invoice_card_item.dart';

class InvoicesScreen extends StatefulWidget {
  const InvoicesScreen({super.key});

  @override
  State<InvoicesScreen> createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  String? _selectedStatusBadge;
  String _selectedTimeFrame = "الكل";
  String _selectedPaymentMethod = "الكل";
  final int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<FullInvoicesCubit>().fetchInitialInvoiceData(page: _currentPage);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    String? apiTimePeriod;
    if (_selectedTimeFrame == "اليوم") {
      apiTimePeriod = "today";
    } else if (_selectedTimeFrame == "هذا الشهر") {
      apiTimePeriod = "this_month";
    }

    context.read<FullInvoicesCubit>().fetchInvoicesFiltered(
      page: 1,
      search: _searchController.text,
      status: _selectedStatusBadge,
      timePeriod: apiTimePeriod,
      paymentMethod: _selectedPaymentMethod == "الكل" ? null : _selectedPaymentMethod,
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final fullInvoicesCubit = context.read<FullInvoicesCubit>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: fullInvoicesCubit,
          child: BlocBuilder<FullInvoicesCubit, FullInvoicesState>(
            builder: (context, state) {
              int totalResults = 0;
              var statuses = [];
              if (state is FullInvoicesSuccess) {
                totalResults = state.invoiceList.total;
                statuses = state.statusDefinitions;
              }

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: const Color(0xff111827), size: 22.w),
                              onPressed: () => Navigator.pop(context),
                            ),
                            Text(
                              "فلتر",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff111827),
                              ),
                            ),
                            Text(
                              "$totalResults نتيجة",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 12.sp,
                                color: const Color(0xff6B7280),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),

                        _buildSectionTitle("حالة الفاتورة"),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            textDirection: TextDirection.rtl, // 🟢 تم نقلها هنا جوه الـ Row بشكل صحيح
                            children: [
                              _buildFilterChip(
                                label: "الكل",
                                isSelected: _selectedStatusBadge == null,
                                onTap: () => setModalState(() => _selectedStatusBadge = null),
                              ),
                              ...statuses.map((statusDef) {
                                return Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: _buildFilterChip(
                                    label: statusDef.label,
                                    isSelected: _selectedStatusBadge == statusDef.badge,
                                    onTap: () => setModalState(() => _selectedStatusBadge = statusDef.badge),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),

                        _buildSectionTitle("الفترة الزمنية"),
                        SizedBox(height: 10.h),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            _buildFilterChip(
                              label: "الكل",
                              isSelected: _selectedTimeFrame == "الكل",
                              onTap: () => setModalState(() => _selectedTimeFrame = "الكل"),
                            ),
                            SizedBox(width: 8.w),
                            _buildFilterChip(
                              label: "اليوم",
                              isSelected: _selectedTimeFrame == "اليوم",
                              onTap: () => setModalState(() => _selectedTimeFrame = "اليوم"),
                            ),
                            SizedBox(width: 8.w),
                            _buildFilterChip(
                              label: "هذا الشهر",
                              isSelected: _selectedTimeFrame == "هذا الشهر",
                              onTap: () => setModalState(() => _selectedTimeFrame = "هذا الشهر"),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        _buildSectionTitle("طريقة الدفع"),
                        SizedBox(height: 10.h),
                        Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            _buildFilterChip(
                              label: "الكل",
                              isSelected: _selectedPaymentMethod == "الكل",
                              onTap: () => setModalState(() => _selectedPaymentMethod = "الكل"),
                            ),
                            SizedBox(width: 8.w),
                            _buildFilterChip(
                              label: "بطاقة",
                              isSelected: _selectedPaymentMethod == "Card",
                              onTap: () => setModalState(() => _selectedPaymentMethod = "Card"),
                            ),
                            SizedBox(width: 8.w),
                            _buildFilterChip(
                              label: "تحويل",
                              isSelected: _selectedPaymentMethod == "Transfer",
                              onTap: () => setModalState(() => _selectedPaymentMethod = "Transfer"),
                            ),
                            SizedBox(width: 8.w),
                            _buildFilterChip(
                              label: "نقدي",
                              isSelected: _selectedPaymentMethod == "Cash",
                              onTap: () => setModalState(() => _selectedPaymentMethod = "Cash"),
                            ),
                          ],
                        ),
                        SizedBox(height: 32.h),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _applyFilters();
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0D256F),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                  elevation: 0,
                                ),
                                child: Text(
                                  "تطبيق الفلتر",
                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setModalState(() {
                                    _selectedStatusBadge = null;
                                    _selectedTimeFrame = "الكل";
                                    _selectedPaymentMethod = "الكل";
                                  });
                                  _applyFilters();
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xffE5E7EB)),
                                  padding: EdgeInsets.symmetric(vertical: 14.h),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                ),
                                child: Text(
                                  "إعادة تعيين",
                                  style: TextStyle(fontFamily: 'Cairo', fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xff1F2937)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xff374151)),
    );
  }

  Widget _buildFilterChip({required String label, required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffEEF2F6) : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xff0D256F).withOpacity(0.3) : const Color(0xffE5E7EB),
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? const Color(0xff0D256F) : const Color(0xff4B5563),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.authBgColor, size: 24.w),
          onPressed: () => Navigator.pop(context),
        ),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "ابحث برقم الفاتورة...",
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (query) => _applyFilters(),
        )
            : Text("الفواتير", style: TextStyles.font20WhiteMedium),
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: Colors.white, size: 24.w),
            onPressed: () => _showFilterBottomSheet(context),
          ),
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search, color: Colors.white, size: 24.w),
            onPressed: () {
              setState(() {
                if (_isSearching) {
                  _isSearching = false;
                  _searchController.clear();
                  _applyFilters();
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<FullInvoicesCubit, FullInvoicesState>(
        builder: (context, state) {
          if (state is FullInvoicesLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xff0D256F)));
          } else if (state is FullInvoicesFailure) {
            return Center(child: Text(state.message));
          } else if (state is FullInvoicesSuccess) {
            if (state.invoiceList.items.isEmpty) {
              return const EmptyInvoicesView();
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              itemCount: state.invoiceList.items.length,
              itemBuilder: (context, index) {
                return InvoiceCardItem(invoice: state.invoiceList.items[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}