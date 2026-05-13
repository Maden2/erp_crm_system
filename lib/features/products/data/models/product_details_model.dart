import '../../domain/entities/product_details_entity.dart';

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required super.id,
    required super.name,
    required super.price,
    required super.sku,
    required super.brand,
    required super.stock,
    required super.warranty,
    required super.description,
    required super.images,
    required super.colors,
    required super.sizes,
    required super.priceHistory,

    required super.category,
    required super.minOrder,
  });

  /// ================================
  /// FROM JSON
  /// ================================
  factory ProductDetailsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ProductDetailsModel(
      id: json['id'].toString(),

      name: json['name'] ?? '',

      price: json['price'].toString(),

      sku: json['sku'] ?? '',

      brand: json['brand'] ?? 'غير معروفة',

      stock: json['stock'] ?? 0,

      warranty: json['warranty'] ?? 0,

      description: json['description'] ?? '',

      images: List<String>.from(
        json['images'] ?? [],
      ),

      colors: List<int>.from(
        json['colors'] ?? [],
      ),

      sizes: List<String>.from(
        json['sizes'] ?? [],
      ),

      priceHistory: List<double>.from(
        json['price_history'] ?? [],
      ),

      category: json['category'] ?? '',

      minOrder: json['min_order'] ?? 1,
    );
  }
}