import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/website_product_entities.dart';
import '../../domain/repositories/website_product_repository.dart';
import '../datasources/website_product_remote_data_source.dart';

class WebsiteProductRepositoryImpl implements WebsiteProductRepository {
  final WebsiteProductRemoteDataSource remoteDataSource;
  WebsiteProductRepositoryImpl(this.remoteDataSource);


  @override
  Future<Either<Failure, WebsiteProductListEntity>> getWebsiteProducts({
    String? search,
    String? categoryId,
    String? warehouseId, // 🟢 إضافة الـ warehouseId
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    required int page,
    required int limit,
  }) async {
    try {
      final result = await remoteDataSource.getWebsiteProducts(
        search: search,
        categoryId: categoryId,
        warehouseId: warehouseId, // 🟢 تمرير الـ warehouseId
        isPublished: isPublished,
        stockStatus: stockStatus,
        minPrice: minPrice,
        maxPrice: maxPrice,
        page: page,
        limit: limit,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب منتجات المتجر'));
    }
  }

  @override
  Future<Either<Failure, List<WebsiteCategoryEntity>>> getWebsiteCategories({required bool tree}) async {
    try {
      final result = await remoteDataSource.getWebsiteCategories(tree: tree);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب تصنيفات المتجر'));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getInventoryCategories({required bool tree}) async {
    try {
      final result = await remoteDataSource.getInventoryCategories(tree: tree);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب تصنيفات المستودع'));
    }
  }

  @override
  Future<Either<Failure, List<WebsiteUnpublishedProductEntity>>> getUnpublishedProducts({String? categoryId}) async {
    try {
      final result = await remoteDataSource.getUnpublishedProducts(categoryId: categoryId);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب المنتجات غير المنشورة'));
    }
  }

  @override
  Future<Either<Failure, Unit>> publishFromInventory({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  }) async {
    try {
      await remoteDataSource.publishFromInventory(
        inventoryProductId: inventoryProductId,
        price: price,
        isPublished: isPublished,
        websiteCategoryId: websiteCategoryId,
        nameSnapshot: nameSnapshot,
      );
      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure('المنتج مضاف بالفعل أو هناك بيانات ناقصة'));
    }
  }

  @override
  Future<Either<Failure, WebsiteProductDetailEntity>> getWebsiteProductDetails({required String id}) async {
    try {
      final result = await remoteDataSource.getWebsiteProductDetails(id: id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('تعذر العثور على تفاصيل المنتج'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWebsiteProduct({
    required String id,
    double? price,
    bool? isAvailable,
    bool? isPublished,
    int? displayOrder,
    String? categoryId,
    String? nameSnapshot,
    List<dynamic>? images,
  }) async {
    try {
      await remoteDataSource.updateWebsiteProduct(
        id: id,
        price: price,
        isAvailable: isAvailable,
        isPublished: isPublished,
        displayOrder: displayOrder,
        categoryId: categoryId,
        nameSnapshot: nameSnapshot,
        images: images,
      );
      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure('فشل تحديث بيانات المنتج'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWebsiteProduct({required String id}) async {
    try {
      await remoteDataSource.deleteWebsiteProduct(id: id);
      return const Right(unit);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء حذف المنتج من المتجر'));
    }
  }

  @override
  Future<Either<Failure, bool>> togglePublishState({required String id}) async {
    try {
      final result = await remoteDataSource.togglePublishState(id: id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('فشل تعديل حالة نشر المنتج'));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getWarehouses() async {
    try {
      final result = await remoteDataSource.getWarehouses();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب قائمة المخازن'));
    }
  }

  @override
  Future<Either<Failure, List<dynamic>>> getStockMoves({String? productId, String? warehouseId, String? moveType}) async {
    try {
      final result = await remoteDataSource.getStockMoves(
        productId: productId,
        warehouseId: warehouseId,
        moveType: moveType,
      );
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure('حدث خطأ أثناء جلب سجل حركات المخزون'));
    }
  }
}