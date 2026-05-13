import 'package:dartz/dartz.dart';
import 'package:pivot/features/products/domain/entities/product_filter_entity.dart';
import '../../../../core/error/failures.dart';
import '../entities/product_entity.dart';
import '../entities/product_details_entity.dart';
import '../entities/warehouse_history_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    String? query,
    String? warehouseId, ProductFilterEntity? filter,
  });

  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
    String productId,
  );

  Future<Either<Failure, Unit>> copyProductToWarehouse({
    required String productId,
    required String warehouseId,
  });

  Future<Either<Failure, List<WarehouseHistoryEntity>>> getWarehouseHistory();

}
