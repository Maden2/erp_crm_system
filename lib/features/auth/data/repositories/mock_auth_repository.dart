import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email == "test@gmail.com" && password == "123456") {
      return const Right(
        UserModel(
          name: "مدين",
          email: "test@gmail.com",
          token: "mock_token_123",
        ),
      );
    } else {
      return const Left(
        ServerFailure("البريد الإلكتروني أو كلمة المرور غير صحيحة"),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Right(UserModel(name: name, email: email, token: "mock_token_reg"));
  }
}
