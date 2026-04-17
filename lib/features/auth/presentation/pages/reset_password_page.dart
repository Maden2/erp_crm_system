import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../app/app_routes.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isButtonEnabled = false;

  String? passwordErrorText;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(validateInputs);
    confirmPasswordController.addListener(validateInputs);
  }

  void validateInputs() {
    setState(() {

      bool isPasswordMatching = passwordController.text == confirmPasswordController.text;
      if (confirmPasswordController.text.isNotEmpty && !isPasswordMatching) {
        passwordErrorText = "كلمة المرور غير متطابقة";
      } else {
        passwordErrorText = null;
      }


      isButtonEnabled = passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          isPasswordMatching;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
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
        centerTitle: false,
        title: Text(
          "تغيير كلمة المرور",
          style: TextStyles.font20DarkGreyMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: AppColors.whiteLightColor,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("اكتب كلمة المرور الجديدة",
                          style: TextStyles.font12LightGreyRegular),
                      SizedBox(height: 16.h),
                      AppTextField(
                        controller: passwordController,
                        label: "كلمة المرور",
                        isPassword: true,
                        hintText: "***********",
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      SizedBox(height: 20.h),
                      Text("تأكيد كلمة المرور",
                          style: TextStyles.font12LightGreyRegular),
                      SizedBox(height: 16.h),

                      AppTextField(
                        controller: confirmPasswordController,
                        label: "تأكيد كلمة المرور",
                        isPassword: true,
                        hintText: "***********",
                        errorText: passwordErrorText,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      SizedBox(height: 32.h),
                      AppTextButton(
                        buttonText: "تغيير كلمة المرور",
                        onPressed: isButtonEnabled
                            ? () {
                          Navigator.pushNamed(context, Routes.success);
                        }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}