import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';

class CustomerFilterBottomSheet extends StatefulWidget {
  const CustomerFilterBottomSheet({super.key});

  @override
  State<CustomerFilterBottomSheet> createState() => _CustomerFilterBottomSheetState();
}

class _CustomerFilterBottomSheetState extends State<CustomerFilterBottomSheet> {
  String selectedOrderRange = "متوسط";
  bool spendingToggle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("30 نتيجة", style: TextStyles.font12lightGrayTextRegular),
              Row(
                children: [
                  Text("تصفية العملاء", style: TextStyle(fontFamily: 'Cairo', fontSize: 18.sp, fontWeight: FontWeight.bold)),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Text("عدد الطلبات", style: TextStyles.font14BlackMedium),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: ["مرتفع", "متوسط", "قليل"].map((type) {
              final isSelected = selectedOrderRange == type;
              return Container(
                margin: EdgeInsets.only(left: 8.w),
                child: ChoiceChip(
                  label: Text(type),
                  selected: isSelected,
                  onSelected: (_) => setState(() => selectedOrderRange = type),
                  selectedColor: AppColors.primary.withOpacity(0.1),
                  labelStyle: TextStyle(color: isSelected ? AppColors.primary : Colors.grey, fontFamily: 'Cairo'),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),
          Text("إجمالي الإنفاق", style: TextStyles.font14BlackMedium),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(child: _buildPriceField("الحد الأقصى", "6,000")),
              SizedBox(width: 12.w),
              Expanded(child: _buildPriceField("الحد الأدنى", "100")),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: spendingToggle,
                onChanged: (v) => setState(() => spendingToggle = v),
                activeColor: AppColors.primary,
              ),
              Text("إجمالي الإنفاق", style: TextStyles.font14BlackMedium),
            ],
          ),
          SizedBox(height: 28.h),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  buttonText: "تطبيق الفلتر",
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إعادة تعيين", style: TextStyle(color: AppColors.primary, fontFamily: 'Cairo')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: TextStyles.font10lightGrayTextRegular),
        SizedBox(height: 4.h),
        TextField(
          textAlign: TextAlign.right,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        ),
      ],
    );
  }
}