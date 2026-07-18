import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/app_routes.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../manager/splash_cubit.dart';
import '../manager/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<double> _leftAnimation;
  late final Animation<double> _rightAnimation;

  late final Animation<double> _splitBackgroundOpacity; // 💡 أنيميشن اختفاء الخلفية المقسومة

  late final Animation<double> _logoScale;

  late final Animation<double> _whiteLogoOpacity;
  late final Animation<double> _coloredLogoOpacity;

  late final Animation<Color?> _textColor;

  bool _authCheckStarted = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    // 1️⃣ أولاً: الخلفية المقسومة بتتحرك وتختفي من الدقيقة .18 لـ .55
    _leftAnimation = Tween(begin: 0.0, end: -1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.18, .55, curve: Curves.easeInOut),
      ),
    );

    _rightAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.18, .55, curve: Curves.easeInOut),
      ),
    );

    // أنيميشن يختفي بالتدريج للخلفية الملونة عشان تكشف البيضاء بنعومة
    _splitBackgroundOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.40, .60, curve: Curves.linear),
      ),
    );

    // 2️⃣ ثانياً: حجم اللوجو والتحول للملون بيبدأ يظهر بوضوح بعد ما الخلفية تفتح
    _logoScale = Tween(
      begin: .82,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _whiteLogoOpacity = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(.40, .60)),
    );

    _coloredLogoOpacity = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(.55, .80)),
    );

    _textColor = ColorTween(begin: Colors.white, end: const Color(0xff10226E))
        .animate(
      CurvedAnimation(parent: _controller, curve: const Interval(.55, .85)),
    );

    // بدء السيكوانس فوراً
    _controller.forward();

    // 3️⃣ ثالثاً: أول ما الأنيميشن يخلص خالص، يروح يعمل التشيك ويطير على اللوجين
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          !_authCheckStarted &&
          mounted) {
        _authCheckStarted = true;
        context.read<SplashCubit>().checkAuthentication();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is NavigateToHome) {
            Navigator.pushReplacementNamed(context, Routes.navigationPage);
          }
          // 🟢 تم فصل التوجيه بالملي هنا لتوجيه الأون بوردينج بشكل مستقل
          if (state is NavigateToOnBoarding) {
            Navigator.pushReplacementNamed(context, Routes.onBoarding);
          }
          if (state is NavigateToLogin) {
            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              fit: StackFit.expand,
              children: [
                // 🟢 الطبقة الأولى (الأساس): الخلفية البيضاء الثابتة ورا خالص
                Container(color: const Color(0xffF8F9FD)),

                // 🔵 الطبقة الثانية: الخلفية المقسومة (الملونة) فوقيها، وبتختفي عشان تكشف الأبيض
                Opacity(
                  opacity: _splitBackgroundOpacity.value,
                  child: Row(
                    children: [
                      Expanded(
                        child: FractionalTranslation(
                          translation: Offset(_leftAnimation.value, 0),
                          child: Container(color: const Color(0xff003399)),
                        ),
                      ),
                      Expanded(
                        child: FractionalTranslation(
                          translation: Offset(_rightAnimation.value, 0),
                          child: Container(color: const Color(0xff4170F1)),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🎭 الطبقة الثالثة (الفوقية): اللوجو والنصوص والـ Indicator
                SafeArea(
                  child: Column(
                    children: [
                      const Spacer(),

                      ScaleTransition(
                        scale: _logoScale,
                        child: SizedBox(
                          width: 120.w,
                          height: 120.w,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // اللوجو الأبيض (يظهر الأول)
                              Opacity(
                                opacity: _whiteLogoOpacity.value,
                                child: Image.asset(
                                  AppAssets.logoColored,
                                  width: 110.w,
                                ),
                              ),
                              // اللوجو الملون (يظهر بعد اختفاء الملونة)
                              Opacity(
                                opacity: _coloredLogoOpacity.value,
                                child: Image.asset(
                                  AppAssets.logoWhite,
                                  width: 110.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Spacer(),

                      Text(
                        "نصنع لك مستقبل تجارتك",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _textColor.value,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: .2,
                        ),
                      ),
                      SizedBox(height: 20.h,)
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}