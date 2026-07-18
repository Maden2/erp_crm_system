import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/cache_onboarding_usecase.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final CacheOnboardingUseCase cacheOnboardingUseCase;

  // التحكم في الـ PageView حركياً
  final PageController pageController = PageController();
  int currentIndex = 0;

  OnboardingCubit(this.cacheOnboardingUseCase) : super(OnboardingInitial());

  void changePage(int index) {
    currentIndex = index;
    emit(OnboardingPageChanged(index));
  }

  // تخطي أو الضغط على "ابدأ" وحفظ الحالة في الـ SharedPreferences
  Future<void> skipOrCompleteOnboarding() async {
    await cacheOnboardingUseCase();
    emit(OnboardingCachedSuccess());
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}