import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/check_auth_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckAuthUseCase checkAuthUseCase;

  SplashCubit(this.checkAuthUseCase) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    // ندي ثانية وربع عشان الـ Animation بتاع اللوجو يلحق يظهر بنعومة
    await Future.delayed(const Duration(milliseconds: 400));

    final destination = await checkAuthUseCase();

    if (destination == 'onboarding') {
      emit(NavigateToOnBoarding());
    } else if (destination == 'home') {
      emit(NavigateToHome());
    } else {
      emit(NavigateToLogin());
    }
  }
}