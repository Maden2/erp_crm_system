// lib/features/products/domain/usecases/website_product_usecases.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/website_product_entities.dart';
import '../repositories/website_product_repository.dart';

class GetWebsiteProductsUseCase {
  final WebsiteProductRepository repository;
  GetWebsiteProductsUseCase(this.repository);

  Future<Either<Failure, WebsiteProductListEntity>> call({
    String? search,
    String? categoryId,
    String? warehouseId, // 🟢 إضافة الـ warehouseId هنا
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    int page = 1,
    int limit = 20,
  }) {
    return repository.getWebsiteProducts(
      search: search,
      categoryId: categoryId,
      warehouseId: warehouseId, // 🟢 وتمريره هنا للـ repository
      isPublished: isPublished,
      stockStatus: stockStatus,
      minPrice: minPrice,
      maxPrice: maxPrice,
      page: page,
      limit: limit,
    );
  }
}

class GetWebsiteCategoriesUseCase {
  final WebsiteProductRepository repository;
  GetWebsiteCategoriesUseCase(this.repository);

  Future<Either<Failure, List<WebsiteCategoryEntity>>> call({bool tree = false}) {
    return repository.getWebsiteCategories(tree: tree);
  }
}

class PublishFromInventoryUseCase {
  final WebsiteProductRepository repository;
  PublishFromInventoryUseCase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  }) {
    return repository.publishFromInventory(
      inventoryProductId: inventoryProductId,
      price: price,
      isPublished: isPublished,
      websiteCategoryId: websiteCategoryId,
      nameSnapshot: nameSnapshot,
    );
  }
}

class GetWebsiteProductDetailsUseCase {
  final WebsiteProductRepository repository;
  GetWebsiteProductDetailsUseCase(this.repository);

  Future<Either<Failure, WebsiteProductDetailEntity>> call({required String id}) {
    return repository.getWebsiteProductDetails(id: id);
  }
}

class TogglePublishStateUseCase {
  final WebsiteProductRepository repository;
  TogglePublishStateUseCase(this.repository);

  Future<Either<Failure, bool>> call({required String id}) {
    return repository.togglePublishState(id: id);
  }
}

class DeleteWebsiteProductUseCase {
  final WebsiteProductRepository repository;
  DeleteWebsiteProductUseCase(this.repository);

  Future<Either<Failure, Unit>> call({required String id}) {
    return repository.deleteWebsiteProduct(id: id);
  }
}