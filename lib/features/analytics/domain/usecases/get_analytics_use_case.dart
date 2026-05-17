import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/analytics_entity.dart';
import '../repositories/analytics_repository.dart';

class GetAnalyticsUseCase {
  final AnalyticsRepository repository;

  GetAnalyticsUseCase(this.repository);

  Future<Either<Failure, AnalyticsEntity>> call() async {
    return await repository.getAnalytics();
  }
}