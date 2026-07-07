import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_analytics_entity.dart';
import '../repositories/full_analytics_repository.dart';

class GetFullAnalyticsUseCase {
  final FullAnalyticsRepository repository;

  GetFullAnalyticsUseCase(this.repository);

  Future<Either<Failure, FullAnalyticsEntity>> call({
    required String period,
    String? dateFrom,
    String? dateTo,
  }) async {
    return await repository.getFullAnalytics(
      period: period,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }
}