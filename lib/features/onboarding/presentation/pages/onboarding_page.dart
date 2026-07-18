import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/utils/app_assets.dart';
import '../manager/onboarding_cubit.dart';
import '../manager/onboarding_state.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "إدارة متجرك في مكان واحد",
      "desc":
          "تابع منتجاتك وطلباتك ومخزونك وفواتيرك من لوحة تحكم ذكية وسهلة الاستخدام.",
    },
    {
      "title": "تحكّم كامل في طلباتك",
      "desc":
          "اعرف حالة كل طلب لحظة بلحظة، من استلام الطلب وحتى تسليمه للعميل، مع تتبع الشحن وإشعارات فورية.",
    },
    {
      "title": "قرارات أذكى... أداء أقوى",
      "desc":
          "تحليلات دقيقة وتوصيات ذكية تساعدك على فهم مبيعاتك، ومتابعة المنتجات القريبة من النفاد، والتنبؤ بأداء متجرك.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCachedSuccess) {
            Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              // 1️⃣ HEADER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => context
                          .read<OnboardingCubit>()
                          .skipOrCompleteOnboarding(),
                      child: Text(
                        "تخطي",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    // استبدل الـ BlocBuilder بتاع العداد في الـ Header بالكود ده:
                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        final currentIndex =
                            context.read<OnboardingCubit>().currentIndex + 1;
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "$currentIndex",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 20.sp, // حجم أكبر للرقم الحالي
                                  fontWeight: FontWeight.w900, // غامق جداً
                                  color: const Color(0xFF1E293B), // لون غامق
                                ),
                              ),
                              TextSpan(
                                text: "/3",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500, // أخف
                                  color: const Color(
                                    0xFFCBD5E1,
                                  ), // لون رمادي فاتح (بهتان)
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // 2️⃣ PAGE VIEW (تم إضافة Directionality لعكس حركة المحتوى)
              // 2️⃣ PAGE VIEW (تعديل كامل لضمان الحركة لليمين)
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.rtl, // 🟢 بيعكس ترتيب الصفحات
                  child: PageView.builder(
                    controller: context.read<OnboardingCubit>().pageController,
                    reverse: true,
                    // 🟢 جرب السطر ده! لو الصور بتتحرك للشمال، ده هيعكس اتجاه السحب تماماً
                    itemCount: _onboardingData.length,
                    onPageChanged: (index) =>
                        context.read<OnboardingCubit>().changePage(index),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppAssets.onboardingImg,
                              height: 260.h,
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              _onboardingData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF111827),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              _onboardingData[index]["desc"]!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 13.sp,
                                color: const Color(0xFF64748B),
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              // 3️⃣ FOOTER
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        final cubit = context.read<OnboardingCubit>();
                        if (cubit.currentIndex < 2) {
                          cubit.pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          cubit.skipOrCompleteOnboarding();
                        }
                      },
                      child: BlocBuilder<OnboardingCubit, OnboardingState>(
                        builder: (context, state) => Text(
                          context.read<OnboardingCubit>().currentIndex == 2
                              ? "ابدأ"
                              : "التالي",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10226E),
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        final cubit = context.read<OnboardingCubit>();
                        return Row(
                          children: List.generate(3, (index) => index).reversed
                              .map(
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                                  height: 6.h,
                                  width: cubit.currentIndex == index
                                      ? 24.w
                                      : 6.w,
                                  decoration: BoxDecoration(
                                    color: cubit.currentIndex == index
                                        ? const Color(0xFF0052B5)
                                        : const Color(0xFFCBD5E1),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) => Opacity(
                        opacity:
                            context.read<OnboardingCubit>().currentIndex == 0
                            ? 0
                            : 1,
                        child: TextButton(
                          onPressed: () => context
                              .read<OnboardingCubit>()
                              .pageController
                              .previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              ),
                          child: Text(
                            "السابق",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
