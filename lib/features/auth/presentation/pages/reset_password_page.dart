import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../app/app_routes.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  final String? token; // 🟢 استقبال التوكن في الـ Constructor
  const ResetPasswordPage({super.key, this.token});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? resetToken;
  bool isButtonEnabled = false;
  String? passwordErrorText;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 🟢 قراءة التوكن من الـ widget أولاً، وإذا كان null نقرأه من الـ arguments
    resetToken = widget.token ?? ModalRoute.of(context)?.settings.arguments as String?;
    _validateInputs();
  }

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_validateInputs);
    confirmPasswordController.addListener(_validateInputs);
  }

  void _validateInputs() {
    setState(() {
      bool isPasswordMatching = passwordController.text == confirmPasswordController.text;
      passwordErrorText = (confirmPasswordController.text.isNotEmpty && !isPasswordMatching)
          ? "كلمة المرور غير متطابقة" : null;

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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.success, (route) => false);
        } else if (state is ForgotPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.authBgColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text("تغيير كلمة المرور", style: TextStyles.font20DarkGreyMedium),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
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
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "اكتب كلمة المرور الجديدة",
                          style: TextStyles.font12LightGreyRegular,
                        ),
                        SizedBox(height: 16.h),
                        AppTextField(
                          controller: passwordController,
                          label: "كلمة المرور",
                          isPassword: true,
                          hintText: "***********",
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "تأكيد كلمة المرور",
                          style: TextStyles.font12LightGreyRegular,
                        ),
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
                          buttonText: state is ForgotPasswordLoading ? "جاري الحفظ..." : "تغيير كلمة المرور",
                          onPressed: (isButtonEnabled && state is! ForgotPasswordLoading)
                              ? () {
                            if (resetToken != null) {
                              context.read<AuthCubit>().resetPassword(
                                resetToken: resetToken!,
                                newPassword: passwordController.text,
                                confirmPassword: confirmPasswordController.text,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("خطأ: لم يتم العثور على رمز التحقق الممرر")),
                              );
                            }
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
        );
      },
    );
  }
}