import 'package:dio/dio.dart';
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/api_constants.dart';
import '../models/website_product_models.dart';

abstract class WebsiteProductRemoteDataSource {
  Future<WebsiteProductListModel> getWebsiteProducts({
    String? search,
    String? categoryId,
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    required int page,
    required int limit,
  });
  Future<List<WebsiteCategoryModel>> getWebsiteCategories({required bool tree});
  Future<List<dynamic>> getInventoryCategories({required bool tree});
  Future<List<WebsiteUnpublishedProductModel>> getUnpublishedProducts({String? categoryId});
  Future<void> publishFromInventory({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  });
  Future<WebsiteProductDetailModel> getWebsiteProductDetails({required String id});
  Future<void> updateWebsiteProduct({
    required String id,
    double? price,
    bool? isAvailable,
    bool? isPublished,
    int? displayOrder,
    String? categoryId,
    String? nameSnapshot,
    List<dynamic>? images,
  });
  Future<void> deleteWebsiteProduct({required String id});
  Future<bool> togglePublishState({required String id});
}

class WebsiteProductRemoteDataSourceImpl implements WebsiteProductRemoteDataSource {
  final ApiConsumer apiConsumer;
  WebsiteProductRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<WebsiteProductListModel> getWebsiteProducts({
    String? search,
    String? categoryId,
    bool? isPublished,
    String? stockStatus,
    double? minPrice,
    double? maxPrice,
    required int page,
    required int limit,
  }) async {
    // 🟢 الـ apiConsumer بيهندل الـ DioException تلقائياً ويرمي الـ Exception الصح
    final responseData = await apiConsumer.get(
      ApiConstants.websiteProducts,
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'categoryId': categoryId,
        if (isPublished != null) 'isPublished': isPublished,
        if (stockStatus != null) 'stockStatus': stockStatus,
        if (minPrice != null) 'minPrice': minPrice,
        if (maxPrice != null) 'maxPrice': maxPrice,
        'page': page,
        'limit': limit,
      },
    );
    // الـ responseData هنا هي الـ Map المرجعة مباشرة من الـ DioConsumer
    return WebsiteProductListModel.fromJson(responseData['data'] ?? responseData);
  }

  @override
  Future<List<WebsiteCategoryModel>> getWebsiteCategories({required bool tree}) async {
    final responseData = await apiConsumer.get(
      ApiConstants.websiteCategories,
      queryParameters: {'tree': tree},
    );
    final List list = responseData['data'] ?? responseData;
    return list.map((c) => WebsiteCategoryModel.fromJson(c)).toList();
  }

  @override
  Future<List<dynamic>> getInventoryCategories({required bool tree}) async {
    final responseData = await apiConsumer.get(
      ApiConstants.websiteInventoryCategories,
      queryParameters: {'tree': tree},
    );
    return responseData['data'] ?? responseData;
  }

  @override
  Future<List<WebsiteUnpublishedProductModel>> getUnpublishedProducts({String? categoryId}) async {
    final responseData = await apiConsumer.get(
      ApiConstants.websiteUnpublishedProducts,
      queryParameters: {
        if (categoryId != null) 'categoryId': categoryId,
      },
    );
    final List list = responseData['data'] ?? responseData;
    return list.map((p) => WebsiteUnpublishedProductModel.fromJson(p)).toList();
  }

  @override
  Future<void> publishFromInventory({
    required String inventoryProductId,
    required double price,
    required bool isPublished,
    required String websiteCategoryId,
    required String nameSnapshot,
  }) async {
    await apiConsumer.post(
      ApiConstants.publishFromInventory,
      data: {
        'inventoryProductId': inventoryProductId,
        'price': price,
        'isPublished': isPublished,
        'websiteCategoryId': websiteCategoryId,
        'nameSnapshot': nameSnapshot,
      },
    );
  }

  @override
  Future<WebsiteProductDetailModel> getWebsiteProductDetails({required String id}) async {
    final responseData = await apiConsumer.get(ApiConstants.websiteProductDetails(id));
    return WebsiteProductDetailModel.fromJson(responseData['data'] ?? responseData);
  }

  @override
  Future<void> updateWebsiteProduct({
    required String id,
    double? price,
    bool? isAvailable,
    bool? isPublished,
    int? displayOrder,
    String? categoryId,
    String? nameSnapshot,
    List<dynamic>? images,
  }) async {
    final Map<String, dynamic> dataMap = {
      if (price != null) 'price': price,
      if (isAvailable != null) 'isAvailable': isAvailable,
      if (isPublished != null) 'isPublished': isPublished,
      if (displayOrder != null) 'displayOrder': displayOrder,
      if (categoryId != null) 'categoryId': categoryId,
      if (nameSnapshot != null) 'nameSnapshot': nameSnapshot,
    };

    if (images != null) {
      final List<MultipartFile> multipartFiles = [];
      for (var img in images) {
        if (img is String && !img.startsWith('http')) {
          multipartFiles.add(await MultipartFile.fromFile(img));
        }
      }
      if (multipartFiles.isNotEmpty) {
        dataMap['images'] = multipartFiles;
      }
    }

    final formData = FormData.fromMap(dataMap);

    await apiConsumer.patch(
      ApiConstants.updateWebsiteProduct(id),
      data: formData,
    );
  }

  @override
  Future<void> deleteWebsiteProduct({required String id}) async {
    await apiConsumer.delete(ApiConstants.deleteWebsiteProduct(id));
  }

  @override
  Future<bool> togglePublishState({required String id}) async {
    final responseData = await apiConsumer.patch(ApiConstants.toggleWebsiteProductPublish(id));
    return responseData['isPublished'] ?? false;
  }
}