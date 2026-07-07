
/// 1. كيان قائمة منتجات المتجر بالـ Pagination
class WebsiteProductListEntity {
  final int total;
  final int page;
  final int limit;
  final int pages;
  final List<WebsiteProductItemEntity> items;

  const WebsiteProductListEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.pages,
    required this.items,
  });
}

/// 2. كيان عنصر المنتج الفردي داخل القائمة
class WebsiteProductItemEntity {
  final String id;
  final String name;
  final String sku;
  final double salePrice;
  final int quantity;
  final String category;
  final String image;
  final bool isOutOfStock;
  final bool isPublished;
  final String stockStatus; // stable, low, out

  const WebsiteProductItemEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.salePrice,
    required this.quantity,
    required this.category,
    required this.image,
    required this.isOutOfStock,
    required this.isPublished,
    required this.stockStatus,
  });
}

/// 3. كيان تفاصيل المنتج الكاملة (لشاشة التفاصيل)
class WebsiteProductDetailEntity {
  final String id;
  final String name;
  final String sku;
  final double price;
  final int quantity;
  final String description;
  final List<String> images;
  final String category;
  final List<String> colors;
  final List<String> sizes;
  final int minStockAlert;
  final bool isAvailable;
  final bool isPublished;
  final int displayOrder;

  const WebsiteProductDetailEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.quantity,
    required this.description,
    required this.images,
    required this.category,
    required this.colors,
    required this.sizes,
    required this.minStockAlert,
    required this.isAvailable,
    required this.isPublished,
    required this.displayOrder,
  });
}

/// 4. كيان التصنيفات للمتجر الإلكتروني (Categories)
class WebsiteCategoryEntity {
  final String id;
  final String name;
  final String nameEn;
  final int productCount;
  final List<WebsiteCategoryEntity>? children;

  const WebsiteCategoryEntity({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.productCount,
    this.children,
  });
}

/// 5. كيان منتجات المستودع غير المنشورة (Unpublished) لشاشة النسخ
class WebsiteUnpublishedProductEntity {
  final String id;
  final String name;
  final String sku;
  final String categoryName;
  final String publishState; // not_added, unpublished

  const WebsiteUnpublishedProductEntity({
    required this.id,
    required this.name,
    required this.sku,
    required this.categoryName,
    required this.publishState,
  });
}