import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/warehouse_history_entity.dart';
import '../repositories/product_repository.dart';

class GetWarehouseHistoryUseCase {
  final ProductRepository repository;
  GetWarehouseHistoryUseCase(this.repository);

  Future<Either<Failure, List<WarehouseHistoryEntity>>> call() async {
    return await repository.getWarehouseHistory();
  }
}