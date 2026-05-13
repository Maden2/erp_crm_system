import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/product_repository.dart';

class CopyProductUseCase {
  final ProductRepository repository;

  CopyProductUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String productId,
    required String warehouseId,
  }) async {
    return await repository.copyProductToWarehouse(
      productId: productId,
      warehouseId: warehouseId,
    );
  }
}