import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  });

  Future<Either<Failure, UserEntity>> getCurrentUser();

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  });

  // 💡 Forgot Password Interfaces
  Future<Either<Failure, String>> requestOtp({required String email});
  Future<Either<Failure, String>> verifyOtp({required String email, required String otp});

  // 🟢 الخطوة الثالثة والأخيرة لتغيير كلمة المرور
  Future<Either<Failure, void>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  });
}