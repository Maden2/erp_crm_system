import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isTermsAccepted = false;
  bool isButtonEnabled = false;
  String? passwordErrorText;

  @override
  void initState() {
    super.initState();

    nameController.addListener(validate);
    emailController.addListener(validate);
    passwordController.addListener(validate);
    confirmPasswordController.addListener(validate);
  }

  void validate() {
    setState(() {
      bool isPasswordMatching =
          passwordController.text == confirmPasswordController.text;

      if (confirmPasswordController.text.isNotEmpty && !isPasswordMatching) {
        passwordErrorText = "كلمة المرور غير متطابقة";
      } else {
        passwordErrorText = null;
      }

      isButtonEnabled =
          nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          isPasswordMatching &&
          isTermsAccepted;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Image.asset(
                'assets/images/logo.png',
                height: 60.h,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, size: 60),
              ),
              SizedBox(height: 20.h),
              Text("مرحباً بك معنا👋", style: TextStyles.font24PrimaryBold),
              Text(
                "أنشئ حسابك وابدأ إدارة نظامك باحتراف.",
                style: TextStyles.font14GreyRegular,
              ),
              SizedBox(height: 30.h),

              AppTextField(
                controller: nameController,
                label: "اسم العلامة التجارية",
                hintText: "Kodak",
                prefixIcon: const Icon(Icons.text_fields),
              ),
              SizedBox(height: 16.h),

              AppTextField(
                controller: emailController,
                label: "البريد الإلكتروني",
                hintText: "example@gmail.com",
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              SizedBox(height: 16.h),

              AppTextField(
                controller: passwordController,
                label: "كلمة المرور",
                hintText: "***********",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              SizedBox(height: 16.h),

              AppTextField(
                controller: confirmPasswordController,
                label: "تأكيد كلمة المرور",
                hintText: "***********",
                isPassword: true,
                errorText: passwordErrorText,
                prefixIcon: const Icon(Icons.lock_outline),
              ),

              SizedBox(height: 15.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    onChanged: (val) {
                      setState(() {
                        isTermsAccepted = val ?? false;
                        validate();
                      });
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "إنشاء الحساب يعني موافقتك على \n",
                            style: TextStyles.font14DarkGreyRegular,
                          ),
                          TextSpan(
                            text: "الشروط والأحكام",
                            style: TextStyles.font14DarkGreyRegular.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              AppTextButton(
                buttonText: "إنشاء حساب",
                onPressed: isButtonEnabled
                    ? () {
                        Navigator.pushNamed(context, Routes.phoneNumber);
                      }
                    : null,
              ),

              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "هل لديك حساب؟",
                    style: TextStyles.font14DarkGreyRegular,
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyles.font14PrimaryBold.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
