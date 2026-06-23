class ProductFilterEntity {
  final List<String>? publishStatus;
  final List<String>? stockStatus;
  final List<String>? category;

  final double? minPrice;
  final double? maxPrice;

  ProductFilterEntity({
    this.publishStatus,
    this.stockStatus,
    this.category,
    this.minPrice,
    this.maxPrice,
  });

  ProductFilterEntity copyWith({
    List<String>? publishStatus,
    List<String>? stockStatus,
    List<String>? category,
    double? minPrice,
    double? maxPrice,
  }) {
    return ProductFilterEntity(
      publishStatus: publishStatus ?? this.publishStatus,

      stockStatus: stockStatus ?? this.stockStatus,

      category: category ?? this.category,

      minPrice: minPrice ?? this.minPrice,

      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  bool get isEmpty {
    return (publishStatus == null || publishStatus!.isEmpty) &&
        (stockStatus == null || stockStatus!.isEmpty) &&
        (category == null || category!.isEmpty) &&
        minPrice == null &&
        maxPrice == null;
  }
}
