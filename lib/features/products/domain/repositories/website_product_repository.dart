// lib/features/products/domain/repositories/website_product_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/website_product_entities.dart';

abstract class WebsiteProductRepository {

  // 1. جلب قائمة منتجات المتجر المفلترة والمقسمة صفحات
  Future<Either<Failure, WebsiteProductListEntity>> getWebsiteProducts({
    String? search,
    String? categoryId,
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    required int page,
    required int limit,
  });

  // 2. جلب تصنيفات المتجر الإلكتروني
  Future<Either<Failure, List<WebsiteCategoryEntity>>> getWebsiteCategories({required bool tree});

  // 3. جلب تصنيفات المستودع المتاحة للـ Mapping
  Future<Either<Failure, List<dynamic>>> getInventoryCategories({required bool tree});

  // 4. جلب منتجات المستودع غير المنشورة
  Future<Either<Failure, List<WebsiteUnpublishedProductEntity>>> getUnpublishedProducts({String? categoryId});

  // 5. نشر منتج من المستودع (نسخ المنتج لفئة معينة)
  Future<Either<Failure, Unit>> publishFromInventory({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  });

  // 6. جلب تفاصيل منتج معين الكاملة
  Future<Either<Failure, WebsiteProductDetailEntity>> getWebsiteProductDetails({required String id});

  // 7. تعديل منتج (Update price / availability / display order)
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

  // 8. حذف منتج من المتجر نهائياً
  Future<Either<Failure, Unit>> deleteWebsiteProduct({required String id});

  // 9. تبديل حالة النشر طلقة واحدة (Toggle IsPublished)
  Future<Either<Failure, bool>> togglePublishState({required String id});
}