import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../entities/product_filter_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call({
    String? query,
    String? warehouseId,
    ProductFilterEntity? filter,
  }) {
    return repository.getProducts(
      query: query,
      warehouseId: warehouseId,
      filter: filter,
    );
  }
}
