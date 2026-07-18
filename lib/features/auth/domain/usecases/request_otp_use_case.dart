import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RequestOtpUseCase {
  final AuthRepository repository;
  RequestOtpUseCase(this.repository);

  // لاحظ هنا أضفنا {required String email}
  Future<Either<Failure, String>> call({required String email}) =>
      repository.requestOtp(email: email);
}