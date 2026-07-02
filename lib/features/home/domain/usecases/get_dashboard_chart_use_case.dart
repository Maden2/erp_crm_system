import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/dashboard_chart_point_entity.dart';
import '../repositories/home_repository.dart';

class GetDashboardChartUseCase {
  final HomeRepository repository;

  GetDashboardChartUseCase(this.repository);

  Future<Either<Failure, List<DashboardChartPointEntity>>> call({required String period}) async {
    return await repository.getSalesChart(period: period);
  }
}