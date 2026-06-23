import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  final phoneController = TextEditingController();
  bool isButtonEnabled = false;

  String countryCode = "20";
  String countryFlag = "🇪🇬";

  @override
  void initState() {
    super.initState();
    phoneController.addListener(_validate);
  }

  void _validate() {
    setState(() {
      isButtonEnabled = phoneController.text.length >= 10;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              Text("رقم الهاتف", style: TextStyles.font24PrimaryBold),
              SizedBox(height: 6.h),
              Text(
                "الرجاء إدخال رقم الهاتف",
                style: TextStyles.font14GreyRegular,
              ),
              SizedBox(height: 40.h),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            countryCode = country.phoneCode;
                            countryFlag = country.flagEmoji;
                          });
                        },
                      );
                    },
                    child: Container(
                      height: 56.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(countryFlag, style: TextStyle(fontSize: 20.sp)),

                          SizedBox(width: 8.w),
                          Text(
                            "+$countryCode",
                            style: TextStyles.font12DarkGreyRegular,
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 20.sp,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 10.w),

                  Expanded(
                    child: AppTextField(
                      controller: phoneController,
                      label: "رقم الهاتف",
                      hintText: "01015342445",
                      prefixIcon: const Icon(Icons.phone_android_outlined),

                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              AppTextButton(
                buttonText: "متابعة",
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.pushNamed(context, Routes.signupSuccess);
                      }
                    : null,
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
