// lib/features/products/data/models/website_product_models.dart

import '../../domain/entities/website_product_entities.dart';

class WebsiteProductListModel extends WebsiteProductListEntity {
  const WebsiteProductListModel({
    required super.total,
    required super.page,
    required super.limit,
    required super.pages,
    required super.items,
  });

  factory WebsiteProductListModel.fromJson(Map<String, dynamic> json) {
    return WebsiteProductListModel(
      total: json['total'] ?? json['Total'] ?? 0,
      page: json['page'] ?? json['Page'] ?? 1,
      limit: json['limit'] ?? json['Limit'] ?? 20,
      pages: json['pages'] ?? json['Pages'] ?? 1,
      items: (json['items'] as List?)
          ?.map((i) => WebsiteProductItemModel.fromJson(i))
          .toList() ?? [],
    );
  }
}

class WebsiteProductItemModel extends WebsiteProductItemEntity {
  const WebsiteProductItemModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.salePrice,
    required super.quantity,
    required super.category,
    required super.image,
    required super.isOutOfStock,
    required super.isPublished,
    required super.stockStatus,
  });

  factory WebsiteProductItemModel.fromJson(Map<String, dynamic> json) {
    return WebsiteProductItemModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      sku: json['Sku'] ?? json['sku'] ?? '',
      salePrice: (json['Price'] ?? json['price'] ?? json['salePrice'] ?? 0).toDouble(),
      quantity: json['StockQuantity'] ?? json['stockQuantity'] ?? json['quantity'] ?? 0,
      category: json['CategoryName'] ?? json['category'] ?? '',
      image: json['PrimaryImage'] ?? json['image'] ?? '',
      isOutOfStock: json['IsOutOfStock'] ?? json['isOutOfStock'] ?? false,
      isPublished: json['IsPublished'] ?? json['isPublished'] ?? false,
      stockStatus: json['stockStatus'] ?? 'stable',
    );
  }
}

class WebsiteProductDetailModel extends WebsiteProductDetailEntity {
  const WebsiteProductDetailModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.price,
    required super.quantity,
    required super.description,
    required super.images,
    required super.category,
    required super.colors,
    required super.sizes,
    required super.minStockAlert,
    required super.isAvailable,
    required super.isPublished,
    required super.displayOrder,
  });

  factory WebsiteProductDetailModel.fromJson(Map<String, dynamic> json) {
    // 🟢 استخراج المخزون الكلي الجاهز من الـ stockSummary المبعوث من السيرفر
    final stockSummary = json['stockSummary'] as Map<String, dynamic>?;
    final int totalStock = stockSummary?['totalAvailable'] ?? json['StockQuantity'] ?? json['quantity'] ?? 0;

    // 🟢 معالجة لستة الصور إذا رجعت كـ Objects تحتوي على ImagePath من السيرفر
    List<String> parsedImages = [];
    if (json['images'] != null && json['images'] is List) {
      parsedImages = (json['images'] as List).map((img) {
        if (img is Map && img['ImagePath'] != null) {
          return img['ImagePath'].toString();
        }
        return img.toString();
      }).toList();
    }

    return WebsiteProductDetailModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      sku: json['Sku'] ?? json['sku'] ?? '',
      price: (json['Price'] ?? json['price'] ?? 0).toDouble(),
      quantity: totalStock, // 🟢 ربط المخزون بالرقم الديناميكي المستخرج
      description: json['Description'] ?? json['description'] ?? '',
      images: parsedImages,
      category: json['CategoryName'] ?? json['category'] ?? '',
      colors: (json['colors'] as List?)?.map((c) => c.toString()).toList() ?? [],
      sizes: (json['sizes'] as List?)?.map((s) => s.toString()).toList() ?? [],
      minStockAlert: json['minStockAlert'] ?? 0,
      isAvailable: json['IsAvailable'] ?? json['isAvailable'] ?? true,
      isPublished: json['IsPublished'] ?? json['isPublished'] ?? false,
      displayOrder: json['DisplayOrder'] ?? json['displayOrder'] ?? 0,
    );
  }
}

class WebsiteCategoryModel extends WebsiteCategoryEntity {
  const WebsiteCategoryModel({
    required super.id,
    required super.name,
    required super.nameEn,
    required super.productCount,
    super.children,
  });

  factory WebsiteCategoryModel.fromJson(Map<String, dynamic> json) {
    return WebsiteCategoryModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      nameEn: json['NameEn'] ?? json['nameEn'] ?? '',
      productCount: json['ProductCount'] ?? json['productCount'] ?? 0,
      children: (json['children'] as List?)
          ?.map((c) => WebsiteCategoryModel.fromJson(c))
          .toList(),
    );
  }
}

class WebsiteUnpublishedProductModel extends WebsiteUnpublishedProductEntity {
  const WebsiteUnpublishedProductModel({
    required super.id,
    required super.name,
    required super.sku,
    required super.categoryName,
    required super.publishState,
  });

  factory WebsiteUnpublishedProductModel.fromJson(Map<String, dynamic> json) {
    return WebsiteUnpublishedProductModel(
      id: json['Id'] ?? json['id'] ?? '',
      name: json['Name'] ?? json['name'] ?? '',
      sku: json['Sku'] ?? json['sku'] ?? '',
      categoryName: json['CategoryName'] ?? json['categoryName'] ?? '',
      publishState: json['PublishState'] ?? json['publishState'] ?? 'not_added',
    );
  }
}