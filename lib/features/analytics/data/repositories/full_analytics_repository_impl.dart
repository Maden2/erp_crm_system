import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/full_analytics_entity.dart';
import '../../domain/repositories/full_analytics_repository.dart';
import '../datasources/full_analytics_remote_data_source.dart';

class FullAnalyticsRepositoryImpl implements FullAnalyticsRepository {
  final FullAnalyticsRemoteDataSource remoteDataSource;

  FullAnalyticsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, FullAnalyticsEntity>> getFullAnalytics({
    required String period,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final remoteAnalytics = await remoteDataSource.getFullAnalytics(
        period: period,
        dateFrom: dateFrom,
        dateTo: dateTo,
      );
      return Right(remoteAnalytics);
    } on ServerException catch (exception) {
      return Left(ServerFailure(exception.message)); // تأكد من مسمى الـ Failure ومحتواه عندك
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}