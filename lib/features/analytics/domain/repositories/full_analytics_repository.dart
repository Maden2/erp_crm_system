import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/full_analytics_entity.dart';

abstract class FullAnalyticsRepository {
  Future<Either<Failure, FullAnalyticsEntity>> getFullAnalytics({
    required String period,
    String? dateFrom,
    String? dateTo,
  });
}