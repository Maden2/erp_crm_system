import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import 'package:pivot/core/widgets/custom_app_bar.dart';
import '../../../../core/utils/app_assets.dart';
import '../../domain/entities/live_order_entity.dart';
import '../manager/live_orders_cubit.dart';
import '../manager/live_orders_state.dart';
import '../widgets/details/customer_info_card.dart';
import '../widgets/details/customer_note_box.dart';
import '../widgets/details/order_products_card.dart';
import '../widgets/details/order_status_header.dart';
import '../widgets/details/order_summary_card.dart';
import '../widgets/details/shipping_info_card.dart';
import '../widgets/details/payment_info_card.dart';

class OrderDetailsPage extends StatefulWidget {
  final LiveOrderEntity order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {

  // 🟢 ميثود توليد الفاتورة PDF (تتطلب مكتبة printing)
  Future<void> _generatePdf(LiveOrderEntity order) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Text("فاتورة طلب: ${order.orderNumber}",
            style: const pw.TextStyle(fontSize: 30)),
      );
    }));
    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        title: Text("تفاصيل الطلب ${widget.order.orderNumber}", style: TextStyles.font20WhiteMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<LiveOrdersCubit, LiveOrdersState>(
        builder: (context, state) {
          if (state is LiveOrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          LiveOrderEntity currentOrder = widget.order;
          if (state is LiveOrderDetailsSuccess) {
            currentOrder = state.order;
          }

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              children: [
                OrderStatusHeader(
                  order: currentOrder,
                  date: _formatDate(currentOrder.orderDate),
                ),
                SizedBox(height: 16.h),
                CustomerInfoCard(order: currentOrder),
                SizedBox(height: 14.h),
                OrderProductsCard(order: currentOrder),
                SizedBox(height: 14.h),
                OrderSummaryCard(order: currentOrder),
                SizedBox(height: 14.h),
                PaymentInfoCard(order: currentOrder),
                SizedBox(height: 14.h),
                ShippingInfoCard(order: currentOrder),
                if (currentOrder.customerNote != null && currentOrder.customerNote!.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  CustomerNoteBox(note: currentOrder.customerNote!),
                ],
                SizedBox(height: 16.h),
                _buildActionButtons(context, currentOrder),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}";
  }

  Widget _buildActionButtons(BuildContext context, LiveOrderEntity order) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              // 🟢 إضافة التأكيد قبل الإلغاء
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("إلغاء الطلب"),
                  content: const Text("هل أنت متأكد من إلغاء هذا الطلب؟"),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("لا")),
                    TextButton(
                      onPressed: () {
                        context.read<LiveOrdersCubit>().updateStatus(order.id, 4);
                        Navigator.pop(ctx);
                      },
                      child: const Text("نعم", style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0x1AEF4C53),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("إلغاء الطلب", style: TextStyles.font12RedMedium),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            onPressed: () {
              // فتح الـ BottomSheet للتحديث
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.navSelectedColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 8.w),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "تحديث حالة الطلب",
                style: TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: TextButton.icon(
            onPressed: () => _generatePdf(order), // 🟢 ربط الطباعة
            style: TextButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w)),
            icon: SvgPicture.asset(
              AppAssets.printIcon,
              width: 14.w,
              height: 14.h,
              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            label: Text(
              "طباعة الفاتورة",
              style: TextStyle(fontFamily: 'Cairo', fontSize: 12.sp, color: const Color(0xFF333333)),
            ),
          ),
        ),
      ],
    );
  }
}