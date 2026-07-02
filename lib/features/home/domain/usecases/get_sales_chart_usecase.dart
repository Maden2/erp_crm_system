import '../entities/sales_chart_entity.dart';
import '../repositories/home_repository.dart';

class GetSalesChartUseCase {
  final HomeRepository repository;

  GetSalesChartUseCase(this.repository);

  Future<List<SalesChartPointEntity>> call({required String filter}) async {
    final result = await repository.getSalesChartOld(filter: filter); // تنده على Old بس

    return result.fold(
          (failure) => throw Exception(failure.message),
          (data) => data,
    );
  }
}