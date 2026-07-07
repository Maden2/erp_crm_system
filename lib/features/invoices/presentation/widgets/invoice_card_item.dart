import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../domain/entities/full_invoice_entities.dart';
import '../manager/full_invoices_cubit.dart';
import 'status_badge.dart';
import '../pages/invoice_details_screen.dart';

class InvoiceCardItem extends StatelessWidget {
  final FullInvoiceItemEntity invoice;

  const InvoiceCardItem({
    super.key,
    required this.invoice,
  });

  /// تنسيق التاريخ ليظهر بالشكل:
  /// 12 يناير 2025 - 3:42 م
  String _formatArabicDate(String rawDate) {
    try {
      final date = DateTime.parse(rawDate).toLocal();

      const months = [
        '',
        'يناير',
        'فبراير',
        'مارس',
        'أبريل',
        'مايو',
        'يونيو',
        'يوليو',
        'أغسطس',
        'سبتمبر',
        'أكتوبر',
        'نوفمبر',
        'ديسمبر',
      ];

      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'م' : 'ص';

      return '${date.day} ${months[date.month]} ${date.year} - $hour:$minute $period';
    } catch (_) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () async { // 🟢 جعلنا الدالة async لالتقاط لحظة الرجوع
          final fullInvoicesCubit = context.read<FullInvoicesCubit>();

          // 🟢 الانتظار لحين العودة من شاشة التفاصيل
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: fullInvoicesCubit,
                child: InvoiceDetailsScreen(
                  invoiceId: invoice.id,
                ),
              ),
            ),
          );

          // 🟢 إعادة استدعاء اللستة فوراً بمجرد الرجوع لتنعش الـ State وترسم الكروت مجدداً
          fullInvoicesCubit.fetchInitialInvoiceData(page: 1);
        },
        child: Padding(
          padding: EdgeInsets.all(14.w),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            invoice.invoiceNumber,
                            style: TextStyles.font12BlackMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        StatusBadge(
                          label: invoice.statusLabel,
                          colorHex: invoice.statusColor,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      _formatArabicDate(invoice.orderDate),
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // 🟢 تم إزالة سطر "العميل" بالكامل ليتطابق مع ديزاين فيجما النظيف والأصلي
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "الإجمالي:",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${invoice.totalAmount.toStringAsFixed(2)} EGP",
                    style: TextStyles.font10BlackMedium,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${invoice.itemCount} منتجات",
                    style: TextStyle(
                      fontSize: 9.sp,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10.w),
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}