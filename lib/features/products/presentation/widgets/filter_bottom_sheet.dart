import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/widgets/app_text_button.dart';
import '../../domain/entities/website_product_entities.dart'; //[cite: 8]

class FilterBottomSheet extends StatefulWidget {
  final WebsiteProductListEntity initialFilter; // ربط بالـ Entity الحقيقية[cite: 8]
  final Function(WebsiteProductListEntity) onApply; //[cite: 8]
  final VoidCallback onReset; //[cite: 8]

  const FilterBottomSheet({
    super.key,
    required this.initialFilter,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late WebsiteProductListEntity tempFilter; //[cite: 8]

  @override
  void initState() {
    super.initState();
    tempFilter = widget.initialFilter; //[cite: 8]
  }

  bool get hasSelectedFilter {
    return tempFilter.items.isNotEmpty; //[cite: 8]
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 743.h, //[cite: 8]
      width: double.infinity, //[cite: 8]
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h), //[cite: 8]
      decoration: BoxDecoration(
        color: Colors.white, //[cite: 8]
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)), //[cite: 8]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //[cite: 8]
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, //[cite: 8]
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context), //[cite: 8]
                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF60635E), //[cite: 8]
                      size: 36.sp, //[cite: 8]
                    ),
                  ),
                  SizedBox(width: 16.w), //[cite: 8]
                  Text(
                    "فلتر", //[cite: 8]
                    style: TextStyles.font18WhiteBold.copyWith(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontSize: 22.sp, //[cite: 8]
                    ),
                  ),
                ],
              ),
              Text(
                "30 نتيجة", //[cite: 8]
                style: TextStyles.font18graphiteGreyMedium.copyWith(
                  fontSize: 20.sp, //[cite: 8]
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), //[cite: 8]
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //[cite: 8]
                children: [
                  SizedBox(height: 28.h), //[cite: 8]
                  _buildFilterTitle("حالة النشر"), //[cite: 8]
                  _buildChoiceChips(
                    ["الكل", "منشور", "غير منشور"],
                    const [], // متوافق مع الداتا الحقيقية[cite: 8]
                        (val) {},
                  ),
                  _buildFilterTitle("حالة المخزون"), //[cite: 8]
                  _buildChoiceChips(
                    ["الكل", "مستقر", "منخفض", "نفاد"],
                    const [], //[cite: 8]
                        (val) {},
                  ),
                  _buildFilterTitle("الفئة"), //[cite: 8]
                  _buildChoiceChips(
                    ["الكل", "هواتف", "اكسسوار"],
                    const [], //[cite: 8]
                        (val) {},
                  ),
                  _buildFilterTitle("نطاق السعر"), //[cite: 8]
                  _buildPriceRangeFields(), //[cite: 8]
                  SizedBox(height: 24.h), //[cite: 8]
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h), //[cite: 8]
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  buttonText: "تطبيق الفلتر", //[cite: 8]
                  onPressed: () {
                    widget.onApply(tempFilter); //[cite: 8]
                    Navigator.pop(context); //[cite: 8]
                  },
                ),
              ),
              SizedBox(width: 16.w), //[cite: 8]
              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.onReset(); //[cite: 8]
                    Navigator.pop(context); //[cite: 8]
                  },
                  child: Container(
                    height: 56.h, //[cite: 8]
                    decoration: BoxDecoration(
                      color: Colors.white, //[cite: 8]
                      borderRadius: BorderRadius.circular(16.r), //[cite: 8]
                      border: Border.all(color: AppColors.primary, width: 1.5), //[cite: 8]
                    ),
                    child: Center(
                      child: Text(
                        "إعادة تعيين", //[cite: 8]
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp, //[cite: 8]
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 12.h), //[cite: 8]
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 16.sp, //[cite: 8]
        ),
      ),
    );
  }

  Widget _buildChoiceChips(
      List<String> options,
      List<String> selectedValues,
      Function(List<String>) onSelected,
      ) {
    return Wrap(
      spacing: 12.w, //[cite: 8]
      runSpacing: 8.h, //[cite: 8]
      textDirection: TextDirection.rtl, //[cite: 8]
      children: options.map((option) {
        final bool isSelected = selectedValues.contains(option); //[cite: 8]
        return FilterChip(
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h), //[cite: 8]
            child: Text(option),
          ),
          selected: isSelected, //[cite: 8]
          onSelected: (_) {},
          selectedColor: AppColors.primary.withOpacity(0.1), //[cite: 8]
          backgroundColor: const Color(0xFFF8FAFC), //[cite: 8]
          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey, //[cite: 8]
            fontFamily: 'Cairo',
            fontSize: 14.sp, //[cite: 8]
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r), //[cite: 8]
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent, //[cite: 8]
            ),
          ),
          showCheckmark: false, //[cite: 8]
        );
      }).toList(),
    );
  }

  Widget _buildPriceRangeFields() {
    return Row(
      textDirection: TextDirection.rtl, //[cite: 8]
      children: [
        Expanded(
          child: _buildPriceField(
            "الحد الأدنى", //[cite: 8]
            0.0,
                (val) {},
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w), //[cite: 8]
          child: Text(
            "-", //[cite: 8]
            style: TextStyle(fontSize: 22.sp, color: Colors.grey), //[cite: 8]
          ),
        ),
        Expanded(
          child: _buildPriceField(
            "الحد الأقصى", //[cite: 8]
            60000.0,
                (val) {},
          ),
        ),
      ],
    );
  }

  Widget _buildPriceField(
      String label,
      double value,
      Function(double) onChanged,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h), //[cite: 8]
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FF), //[cite: 8]
        borderRadius: BorderRadius.circular(16.r), //[cite: 8]
      ),
      child: Row(
        children: [
          Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                size: 24.sp, //[cite: 8]
                color: const Color(0xFF94A3B8), //[cite: 8]
              ),
              Icon(
                Icons.keyboard_arrow_down,
                size: 24.sp, //[cite: 8]
                color: const Color(0xFF94A3B8), //[cite: 8]
              ),
            ],
          ),
          const Spacer(), //[cite: 8]
          Column(
            crossAxisAlignment: CrossAxisAlignment.end, //[cite: 8]
            children: [
              Text(
                label, //[cite: 8]
                style: TextStyle(
                  fontSize: 12.sp, //[cite: 8]
                  color: const Color(0xFF64748B), //[cite: 8]
                  fontFamily: 'Cairo',
                ),
              ),
              SizedBox(
                width: 70.w, //[cite: 8]
                child: TextFormField(
                  key: ValueKey(value), //[cite: 8]
                  initialValue: value.toInt().toString(), //[cite: 8]
                  textAlign: TextAlign.end, //[cite: 8]
                  keyboardType: TextInputType.number, //[cite: 8]
                  decoration: const InputDecoration(
                    isDense: true, //[cite: 8]
                    border: InputBorder.none, //[cite: 8]
                    contentPadding: EdgeInsets.zero, //[cite: 8]
                  ),
                  style: TextStyle(
                    fontSize: 16.sp, //[cite: 8]
                    fontWeight: FontWeight.bold, //[cite: 8]
                    color: Colors.black, //[cite: 8]
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}