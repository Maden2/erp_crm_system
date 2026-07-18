abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

// حالة تغيير الصفحة عشان نحدث الـ Dots والأنيميشن
class OnboardingPageChanged extends OnboardingState {
  final int index;
  OnboardingPageChanged(this.index);
}

// حالة النجاح بعد ما ندوس "ابدأ" عشان نعمل الـ Router ونروح للـ Login
class OnboardingCachedSuccess extends OnboardingState {}