import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/low_stock_entity.dart';
import '../repositories/home_repository.dart';

class GetLowStockUseCase {
  final HomeRepository repository;

  GetLowStockUseCase(this.repository);

  Future<Either<Failure, List<LowStockEntity>>> call() {
    return repository.getLowStockProducts();
  }
}
