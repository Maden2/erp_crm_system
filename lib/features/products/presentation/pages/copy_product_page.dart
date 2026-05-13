import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../domain/entities/product_details_entity.dart';
import '../manager/copy_product_cubit.dart';
import '../manager/copy_product_state.dart';

class CopyProductPage extends StatefulWidget {
  final ProductDetailsEntity product;

  const CopyProductPage({
    super.key,
    required this.product,
  });

  @override
  State<CopyProductPage> createState() => _CopyProductPageState();
}

class _CopyProductPageState extends State<CopyProductPage> {
  String? selectedWarehouse;

  final Map<String, String> warehouseMapping = {
    "الكترونيات": "2",
    "ملابس": "3",
    "ألعاب": "4",
  };

  final List<String> warehouses = [
    "الكترونيات",
    "ملابس",
    "ألعاب",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<CopyProductCubit, CopyProductState>(
      listener: (context, state) {
        if (state is CopyProductSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("تم نسخ المنتج بنجاح", textAlign: TextAlign.right),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else if (state is CopyProductFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message, textAlign: TextAlign.right),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.homeBg,
        appBar: CustomAppBar(
          title: Text(
            "نسخ المنتج",
            style: TextStyles.font18WhiteBold.copyWith(fontFamily: 'Cairo'),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductCard(),
              SizedBox(height: 24.h),
              Text(
                "اختر المخزن المستهدف",
                style: TextStyles.font14PrimaryBold,
              ),
              SizedBox(height: 12.h),
              _buildWarehouseDropdown(),
              const Spacer(),

              BlocBuilder<CopyProductCubit, CopyProductState>(
                builder: (context, state) {
                  return AppTextButton(
                    buttonText: "نسخ المنتج",
                    isLoading: state is CopyProductLoading,
                    onPressed: (selectedWarehouse == null || state is CopyProductLoading)
                        ? null
                        : () {
                      _handleCopyAction(context);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "المنتج المراد نسخه",
              style: TextStyles.font14BlackMedium
          ),
          SizedBox(height: 8.h),
          Text(
            widget.product.name,
            style: TextStyles.font12BlackRegular,
          ),
          SizedBox(height: 4.h),
          Text(
            "الفئة: ${widget.product.category}",
            style: TextStyles.font10lightGrayTextRegular,
          ),
          Text(
              "المخزن: الإلكترونيات",
              style: TextStyles.font10lightGrayTextRegular
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: AppColors.authBgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFCEDBE3)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedWarehouse,
          hint: Align(
            alignment: Alignment.centerRight,
            child: Text("اختر المخزون المستهدف", style: TextStyles.font10lightGrayTextRegular),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.lightGrayText),
          items: warehouses.map((String warehouse) {
            return DropdownMenuItem<String>(
              value: warehouse,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(warehouse, style: const TextStyle(fontFamily: 'Cairo')),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedWarehouse = newValue;
            });
          },
        ),
      ),
    );
  }

  void _handleCopyAction(BuildContext context) {
    if (selectedWarehouse != null) {
      context.read<CopyProductCubit>().copyProduct(
        productId: widget.product.id,
        warehouseId: warehouseMapping[selectedWarehouse]!,
      );
    }
  }
}