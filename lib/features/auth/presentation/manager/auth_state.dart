import '../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

// ================== LOGIN STATES ==================
class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  AuthSuccess(this.user);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// ================== FORGOT PASSWORD STATES ==================
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String message;
  ForgotPasswordSuccess(this.message);
}

class ForgotPasswordError extends AuthState {
  final String message;
  ForgotPasswordError(this.message);
}

class OtpVerifiedSuccess extends AuthState {
  final String resetToken;
  OtpVerifiedSuccess(this.resetToken);
}

class ResetPasswordSuccess extends AuthState {} // 🟢 الحالة مسجلة ومظبوطة تماماً

// ================== PROFILE (ME) STATES ==================
class ProfileLoading extends AuthState {}

class ProfileSuccess extends AuthState {
  final UserEntity user;
  ProfileSuccess(this.user);
}

class ProfileError extends AuthState {
  final String message;
  ProfileError(this.message);
}

// ================== LOGOUT STATES ==================
class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutError extends AuthState {
  final String message;
  LogoutError(this.message);
}