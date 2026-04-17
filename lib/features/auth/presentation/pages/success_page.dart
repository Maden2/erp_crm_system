import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';
import '../../../../app/app_routes.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Image.asset(
                'assets/images/success.png',
                height: 260.h,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.check_circle_outline,
                  size: 150.sp,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 40.h),


              Text(
                "تم تغيير كلمة المرور بنجاح!",
                textAlign: TextAlign.center,
                style: TextStyles.font20DarkGreyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "لقد تم تغيير كلمة المرور بنجاح. يُرجى استخدام كلمة المرور الجديدة عند تسجيل الدخول.",
                textAlign: TextAlign.center,
                style: TextStyles.font14GreyRegular.copyWith(height: 1.5),
              ),

              SizedBox(height: 60.h),


              AppTextButton(
                buttonText: "نعم",
                onPressed: () {

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.login,
                        (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}