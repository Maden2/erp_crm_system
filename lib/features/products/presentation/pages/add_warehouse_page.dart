import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class AddWarehousePage extends StatefulWidget {
  const AddWarehousePage({super.key});

  @override
  State<AddWarehousePage> createState() => _AddWarehousePageState();
}

class _AddWarehousePageState extends State<AddWarehousePage> {
  final TextEditingController _warehouseNameController =
      TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _warehouseNameController.addListener(() {
      setState(() {
        _isButtonEnabled = _warehouseNameController.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _warehouseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homeBg,
      appBar: CustomAppBar(
        title: Text(
          "إضافة مخزون",
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
            Text("جميع المخزون", style: TextStyles.font20PrimaryMedium),

            SizedBox(height: 20.h),

            _buildWarehouseTextField(),

            const Spacer(),

            AppTextButton(
              buttonText: "إضافة مخزون",
              onPressed: _isButtonEnabled
                  ? () {
                      _handleSave();
                    }
                  : null,
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildWarehouseTextField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFCEDBE3)),
      ),
      child: TextField(
        controller: _warehouseNameController,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyles.font12lightGrayTextRegular,
        decoration: InputDecoration(
          hintText: "اسم المخزون",
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontFamily: 'Cairo',
            fontSize: 12.sp,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "تم إضافة ${_warehouseNameController.text} بنجاح",
          textAlign: TextAlign.right,
          style: const TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: AppColors.primary,
      ),
    );
    Navigator.pop(context);
  }
}
