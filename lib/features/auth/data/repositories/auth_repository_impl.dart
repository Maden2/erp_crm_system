import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    try {
      final userModel = await remoteDataSource.login(
        email: email,
        password: password,
        rememberMe: rememberMe,
      );
      await localDataSource.cacheToken(userModel.token);
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.clearCache();
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  // 💡 Forgot Password Implementations
  @override
  Future<Either<Failure, String>> requestOtp({required String email}) async {
    try {
      final message = await remoteDataSource.requestOtp(email: email);
      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({required String email, required String otp}) async {
    try {
      final token = await remoteDataSource.verifyOtp(email: email, otp: otp);
      return Right(token);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  // 🟢 تنفيذ ميثود تغيير كلمة المرور النهائية بمعالجة أخطاء السيرفر
  @override
  Future<Either<Failure, void>> resetPassword({
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await remoteDataSource.resetPassword(
        resetToken: resetToken,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      if (response['success'] == true) {
        return const Right(null);
      } else {
        return Left(ServerFailure(response['message'] ?? "حدث خطأ ما", 400));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}