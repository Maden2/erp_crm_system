import '../repositories/home_repository.dart';
import '../entities/sales_chart_entity.dart';

class GetSalesChartUseCase {
  final HomeRepository repository;

  GetSalesChartUseCase(this.repository);

  Future<List<SalesChartPointEntity>> call({
    required String filter,
  }) async {
    final result = await repository.getSalesChart(filter: filter);

    return result.fold(
          (failure) => throw Exception(failure.message),
          (data) => data,
    );
  }
}