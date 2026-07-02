import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/live_order_entity.dart';
import '../repositories/live_orders_repository.dart';

class GetLiveOrdersUseCase {
  final LiveOrdersRepository repository;

  GetLiveOrdersUseCase(this.repository);

  Future<Either<Failure, List<LiveOrderEntity>>> call({
    int? status,
    String? search,
    int? page,
    int? limit,
  }) {
    return repository.getOrders(
      status: status,
      search: search,
      page: page,
      limit: limit,
    );
  }
}