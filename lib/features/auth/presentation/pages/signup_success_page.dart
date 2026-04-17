import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/app_text_button.dart';

class SignupSuccessPage extends StatelessWidget {
  const SignupSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authBgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(),

              // الجزء الخاص بالصورة بعد ضبط الـ fit
              Center(
                child: Container(
                  height: 250.h, // حددنا ارتفاع مناسب عشان الصورة ماتاخدش الشاشة كلها
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w), // مسافة بسيطة من الجوانب
                  child: Image.asset(
                    'assets/images/signup.png', // تأكد من المسار عندك
                    // contain: بيحافظ على أبعاد الصورة الأصلية وبيخليها جوه الـ Container بالكامل
                    // مهما كانت أبعاد الشاشة، الصورة مش هتتمط ولا تتقص.
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              Text(
                "تم التحقق من رقم الهاتف",
                style: TextStyles.font24PrimaryBold,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 16.h),

              Text(
                "تهانينا، تم التحقق من رقم هاتفك. يمكنك البدء باستخدام التطبيق.",
                style: TextStyles.font14GreyRegular,
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              AppTextButton(
                buttonText: "متابعة",
                onPressed: () {
                  // التوجيه للـ Dashboard ومسح الـ History
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.dashboard, // تأكد إن الاسم ده هو اللي في ملف Routes
                        (route) => false,
                  );
                },
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}