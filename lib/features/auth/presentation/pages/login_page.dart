import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../manager/auth_cubit.dart';
import '../manager/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController(
  );

  final TextEditingController passwordController = TextEditingController(
  );

  bool rememberMe = true;
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateInputs);
    passwordController.addListener(_validateInputs);
    _validateInputs(); // ✅ استدعيها من الأول عشان الزرار يكون active
  }

  void _validateInputs() {
    setState(() {
      isButtonEnabled =
          emailController.text.trim().isNotEmpty &&
              passwordController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgColor,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.navigationPage,
                  (route) => false,
            );
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 100.h),

                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 120.w,
                      height: 50.h,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.business,
                        size: 50.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  Text(
                    "مرحباً بعودتك 👋",
                    style: TextStyles.font24PrimaryBold,
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "مرحباً، قم بتسجيل الدخول للمتابعة.",
                    style: TextStyles.font14GreyRegular,
                  ),

                  SizedBox(height: 36.h),

                  AppTextField(
                    controller: emailController,
                    label: "البريد الإلكتروني",
                    hintText: "البريد الإلكتروني",
                    validator: AppValidators.validateEmail,
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),

                  SizedBox(height: 20.h),

                  AppTextField(
                    controller: passwordController,
                    label: "كلمة المرور",
                    hintText: "كلمة المرور",
                    isPassword: true,
                    validator: AppValidators.validatePassword,
                    prefixIcon: const Icon(Icons.lock_outline),
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? true;
                              });
                            },
                            activeColor: AppColors.primary,
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Text(
                            "تذكرني",
                            style: TextStyles.font14GreyRegular,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.forgotPassword,
                          );
                        },
                        child: Text(
                          "نسيت كلمة المرور؟",
                          style: TextStyles.font14GreyRegular,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppTextButton(
                        buttonText: "تسجيل الدخول",
                        isLoading: state is AuthLoading,
                        onPressed: isButtonEnabled
                            ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().emitLoginStates(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              rememberMe: rememberMe,
                            );
                          }
                        }
                            : null,
                      );
                    },
                  ),

                  SizedBox(height: 40.h),

                  Icon(
                    Icons.fingerprint,
                    size: 70.sp,
                    color: AppColors.primary.withOpacity(0.5),
                  ),

                  SizedBox(height: 20.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ليس لديك حساب؟ "),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.signup,
                          );
                        },
                        child: Text(
                          "إنشاء حساب",
                          style: TextStyles.font14PrimaryBold.copyWith(
                            color: AppColors.lightBlue,
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
        ),
      ),
    );
  }
}