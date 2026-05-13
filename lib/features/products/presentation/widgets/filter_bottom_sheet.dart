import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/widgets/app_text_button.dart';
import '../../domain/entities/product_filter_entity.dart';

class FilterBottomSheet extends StatefulWidget {
  final ProductFilterEntity initialFilter;

  final Function(ProductFilterEntity) onApply;

  final VoidCallback onReset;

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
  late ProductFilterEntity tempFilter;

  @override
  void initState() {
    super.initState();

    tempFilter = widget.initialFilter;
  }

  bool get hasSelectedFilter {
    return !tempFilter.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 743.h,

      width: double.infinity,

      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // ================= HEADER =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),

                    icon: Icon(
                      Icons.close,
                      color: const Color(0xFF60635E),
                      size: 36.sp,
                    ),
                  ),

                  SizedBox(width: 16.w),

                  Text(
                    "فلتر",

                    style: TextStyles.font18WhiteBold.copyWith(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontSize: 22.sp,
                    ),
                  ),
                ],
              ),

              Text(
                "30 نتيجة",

                style: TextStyles.font18graphiteGreyMedium.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),

          // ================= BODY =================
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 28.h),

                  // ================= PUBLISH STATUS =================
                  _buildFilterTitle("حالة النشر"),

                  _buildChoiceChips(
                    ["الكل", "منشور", "غير منشور"],

                    tempFilter.publishStatus ?? [],

                    (val) {
                      setState(() {
                        tempFilter = tempFilter.copyWith(publishStatus: val);
                      });
                    },
                  ),

                  // ================= STOCK STATUS =================
                  _buildFilterTitle("حالة المخزون"),

                  _buildChoiceChips(
                    ["الكل", "مستقر", "منخفض", "نفاد"],

                    tempFilter.stockStatus ?? [],

                    (val) {
                      setState(() {
                        tempFilter = tempFilter.copyWith(stockStatus: val);
                      });
                    },
                  ),

                  // ================= CATEGORY =================
                  _buildFilterTitle("الفئة"),

                  _buildChoiceChips(
                    ["الكل", "هواتف", "اكسسوار"],

                    tempFilter.category ?? [],

                    (val) {
                      setState(() {
                        tempFilter = tempFilter.copyWith(category: val);
                      });
                    },
                  ),

                  // ================= PRICE RANGE =================
                  _buildFilterTitle("نطاق السعر"),

                  _buildPriceRangeFields(),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),

          // ================= BUTTONS =================
          SizedBox(height: 16.h),

          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  buttonText: "تطبيق الفلتر",

                  onPressed: hasSelectedFilter
                      ? () {
                          widget.onApply(tempFilter);

                          Navigator.pop(context);
                        }
                      : null,
                ),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: InkWell(
                  onTap: () {
                    widget.onReset();

                    Navigator.pop(context);
                  },

                  child: Container(
                    height: 56.h,

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius: BorderRadius.circular(16.r),

                      border: Border.all(color: AppColors.primary, width: 1.5),
                    ),

                    child: Center(
                      child: Text(
                        "إعادة تعيين",

                        style: TextStyle(
                          color: AppColors.primary,

                          fontFamily: 'Cairo',

                          fontWeight: FontWeight.bold,

                          fontSize: 16.sp,
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

  // ================= TITLE =================

  Widget _buildFilterTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 12.h),

      child: Text(
        title,

        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  // ================= CHIPS =================

  Widget _buildChoiceChips(
    List<String> options,

    List<String> selectedValues,

    Function(List<String>) onSelected,
  ) {
    return Wrap(
      spacing: 12.w,

      runSpacing: 8.h,

      textDirection: TextDirection.rtl,

      children: options.map((option) {
        final bool isSelected = selectedValues.contains(option);

        return FilterChip(
          label: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),

            child: Text(option),
          ),

          selected: isSelected,

          onSelected: (_) {
            List<String> updated = List.from(selectedValues);

            if (updated.contains(option)) {
              updated.remove(option);
            } else {
              updated.add(option);
            }

            onSelected(updated);
          },

          selectedColor: AppColors.primary.withOpacity(0.1),

          backgroundColor: const Color(0xFFF8FAFC),

          labelStyle: TextStyle(
            color: isSelected ? AppColors.primary : Colors.grey,

            fontFamily: 'Cairo',

            fontSize: 14.sp,
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),

            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
            ),
          ),

          showCheckmark: false,
        );
      }).toList(),
    );
  }

  // ================= PRICE RANGE =================

  Widget _buildPriceRangeFields() {
    return Row(
      textDirection: TextDirection.rtl,

      children: [
        Expanded(
          child: _buildPriceField(
            "الحد الأدنى",

            (tempFilter.minPrice ?? 0).toDouble(),

            (val) {
              setState(() {
                tempFilter = tempFilter.copyWith(minPrice: val);
              });
            },
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),

          child: Text(
            "-",

            style: TextStyle(fontSize: 22.sp, color: Colors.grey),
          ),
        ),

        Expanded(
          child: _buildPriceField(
            "الحد الأقصى",

            (tempFilter.maxPrice ?? 60000).toDouble(),

            (val) {
              setState(() {
                tempFilter = tempFilter.copyWith(maxPrice: val);
              });
            },
          ),
        ),
      ],
    );
  }

  // ================= PRICE FIELD =================

  Widget _buildPriceField(
    String label,

    double value,

    Function(double) onChanged,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FF),

        borderRadius: BorderRadius.circular(16.r),
      ),

      child: Row(
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () => onChanged(value + 100),

                child: Icon(
                  Icons.keyboard_arrow_up,
                  size: 24.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ),

              GestureDetector(
                onTap: () {
                  onChanged(value > 0 ? value - 100 : 0);
                },

                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 24.sp,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),

          const Spacer(),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                label,

                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),

                  fontFamily: 'Cairo',
                ),
              ),

              SizedBox(
                width: 70.w,

                child: TextFormField(
                  key: ValueKey(value),

                  initialValue: value.toInt().toString(),

                  textAlign: TextAlign.end,

                  keyboardType: TextInputType.number,

                  onChanged: (v) {
                    final newValue = double.tryParse(v) ?? 0.0;

                    onChanged(newValue);
                  },

                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),

                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
