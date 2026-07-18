import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_current_user_use_case.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/usecases/logout_use_case.dart';
import '../../domain/usecases/request_otp_use_case.dart';
import '../../domain/usecases/verify_otp_use_case.dart';
import '../../domain/usecases/reset_password_use_case.dart'; // 🟢 تم إضافة الـ UseCase الجديدة هنا
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final LogoutUseCase logoutUseCase;
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResetPasswordUseCase resetPasswordUseCase; // 🟢 حقل الـ UseCase الجديد

  AuthCubit(
      this.loginUseCase,
      this.getCurrentUserUseCase,
      this.logoutUseCase,
      this.requestOtpUseCase,
      this.verifyOtpUseCase,
      this.resetPasswordUseCase, // 🟢 تم إضافتها للكونستراكتور بالملي
      ) : super(AuthInitial());

  Future<void> emitLoginStates({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    emit(AuthLoading());
    final result = await loginUseCase(
      email: email.trim(),
      password: password.trim(),
      rememberMe: rememberMe,
    );

    result.fold(
          (failure) => emit(AuthError(failure.message)),
          (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getCurrentUserUseCase();

    result.fold(
          (failure) => emit(ProfileError(failure.message)),
          (user) => emit(ProfileSuccess(user)),
    );
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    final result = await logoutUseCase();

    result.fold(
          (failure) => emit(LogoutError(failure.message)),
          (_) => emit(LogoutSuccess()),
    );
  }

  // ================== FORGOT PASSWORD LOGIC (Clean) ==================
  Future<void> requestOtp(String email) async {
    emit(ForgotPasswordLoading());
    final result = await requestOtpUseCase(email: email);

    result.fold(
          (failure) => emit(ForgotPasswordError(failure.message)),
          (message) => emit(ForgotPasswordSuccess(message)),
    );
  }

  Future<void> verifyOtp(String email, String otp) async {
    emit(ForgotPasswordLoading());
    final result = await verifyOtpUseCase(email: email, otp: otp);

    result.fold(
          (failure) => emit(ForgotPasswordError("الرمز غير صحيح أو انتهت صلاحيته")),
          (token) => emit(OtpVerifiedSuccess(token)),
    );
  }

  // ================== RESET PASSWORD LOGIC (Clean 100%) ==================
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ForgotPasswordLoading());

    // 🟢 نداء الـ UseCase المعتمد بدلاً من الكود المؤقت
    final result = await resetPasswordUseCase(
      resetToken: resetToken,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
          (failure) => emit(ForgotPasswordError(failure.message)),
          (_) => emit(ResetPasswordSuccess()), // إطلاق حالة النجاح لتوجه الـ UI لصفحة النجاح
    );
  }
}