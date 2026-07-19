// lib/features/products/domain/repositories/website_product_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/website_product_entities.dart';

abstract class WebsiteProductRepository {

  // 1. جلب قائمة منتجات المتجر المفلترة والمقسمة صفحات
  Future<Either<Failure, WebsiteProductListEntity>> getWebsiteProducts({
    String? search,
    String? categoryId,
    String? warehouseId, // 🟢 إضافة البارامتر هنا
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    required int page,
    required int limit,
  });

  // ... (باقي الدوال كما هي)
  Future<Either<Failure, List<WebsiteCategoryEntity>>> getWebsiteCategories({required bool tree});
  Future<Either<Failure, List<dynamic>>> getInventoryCategories({required bool tree});
  Future<Either<Failure, List<WebsiteUnpublishedProductEntity>>> getUnpublishedProducts({String? categoryId});

  Future<Either<Failure, Unit>> publishFromInventory({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  });

  Future<Either<Failure, List<dynamic>>> getWarehouses();
  Future<Either<Failure, List<dynamic>>> getStockMoves({String? productId, String? warehouseId, String? moveType});

  Future<Either<Failure, WebsiteProductDetailEntity>> getWebsiteProductDetails({required String id});

  Future<Either<Failure, Unit>> updateWebsiteProduct({
    required String id,
    double? price,
    bool? isAvailable,
    bool? isPublished,
    int? displayOrder,
    String? categoryId,
    String? nameSnapshot,
    List<dynamic>? images,
  });

  Future<Either<Failure, Unit>> deleteWebsiteProduct({required String id});

  Future<Either<Failure, bool>> togglePublishState({required String id});
}