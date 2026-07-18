import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  bool isOtpSent = false;
  bool isButtonEnabled = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateInputs);
    otpController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      if (!isOtpSent) {
        isButtonEnabled = emailController.text.isNotEmpty;
      } else {
        isButtonEnabled = otpController.text.isNotEmpty;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text("نسيت كلمة السر", style: TextStyles.font20DarkGreyMedium),
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
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isOtpSent
                        ? _buildOtpSection()
                        : _buildEmailSection(),
                  ),
                ),

                if (isOtpSent) ...[
                  SizedBox(height: 120.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isOtpSent = false;
                          _validateInputs();
                        });
                      },
                      child: Text(
                        "قم بتغيير البريد الإلكتروني",
                        style: TextStyles.font12redRegular.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailSection() {
    return Column(
      key: const ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("اكتب بريدك الإلكتروني", style: TextStyles.font12LightGreyRegular),
        SizedBox(height: 16.h),
        AppTextField(
          controller: emailController,
          label: "البريد الإلكتروني",
          hintText: "example@mail.com",
        ),
        SizedBox(height: 12.h),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "لقد أرسلنا لك رمزاً للتحقق من بريدك الإلكتروني",
            style: TextStyles.font14DarkGreyRegular,
          ),
        ),
        SizedBox(height: 32.h),
        AppTextButton(
          buttonText: "ارسال",
          onPressed: isButtonEnabled
              ? () {
            setState(() {
              isOtpSent = true;
              isButtonEnabled = false;
            });
          }
              : null,
        ),
      ],
    );
  }

  Widget _buildOtpSection() {
    return Column(
      key: const ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("اكتب الرمز", style: TextStyles.font14GreyRegular),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                controller: otpController,
                label: "رمز",
                hintText: "",
              ),
            ),
            SizedBox(width: 12.w),
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                  child: Text(
                    "إعادة الإرسال",
                    style: TextStyles.font14WhiteRegular,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "لقد أرسلنا لك رمزاً للتحقق من بريدك الإلكتروني.\nسينتهي هذا الرمز بعد 10 دقائق من هذه الرسالة. إذا لم تتلقَ رسالة.",
            textAlign: TextAlign.right,
            style: TextStyles.font14DarkGreyRegular,
          ),
        ),
        SizedBox(height: 32.h),
        AppTextButton(
          buttonText: "تغيير كلمة المرور",
          onPressed: isButtonEnabled
              ? () {
            Navigator.pushNamed(context, Routes.resetPassword);
          }
              : null,
        ),
      ],
    );
  }
}