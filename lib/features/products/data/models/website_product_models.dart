import '../../domain/entities/website_product_entities.dart';

// 🟢 دالة مساعدة عامة لمنع حدوث Crash عند تحويل القيم من السيرفر
bool parseBool(dynamic value) {
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value.toLowerCase() == 'true';
  return false;
}

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
      // 🟢 استخدام الدالة الآمنة هنا
      isOutOfStock: parseBool(json['IsOutOfStock'] ?? json['isOutOfStock']),
      isPublished: parseBool(json['IsPublished'] ?? json['isPublished']),
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
    final stockSummary = json['stockSummary'] as Map<String, dynamic>?;
    final int totalStock = stockSummary?['totalAvailable'] ?? json['StockQuantity'] ?? json['quantity'] ?? 0;

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
      quantity: totalStock,
      description: json['Description'] ?? json['description'] ?? '',
      images: parsedImages,
      category: json['CategoryName'] ?? json['category'] ?? '',
      colors: (json['colors'] as List?)?.map((c) => c.toString()).toList() ?? [],
      sizes: (json['sizes'] as List?)?.map((s) => s.toString()).toList() ?? [],
      minStockAlert: json['minStockAlert'] ?? 0,
      // 🟢 استخدام الدالة الآمنة هنا
      isAvailable: parseBool(json['IsAvailable'] ?? json['isAvailable']),
      isPublished: parseBool(json['IsPublished'] ?? json['isPublished']),
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