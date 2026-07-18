import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;
  VerifyOtpUseCase(this.repository);

  // لاحظ هنا أضفنا الـ Named Parameters
  Future<Either<Failure, String>> call({required String email, required String otp}) =>
      repository.verifyOtp(email: email, otp: otp);
}