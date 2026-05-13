import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final String price;
  final String image;
  final int quantity;
  final String category;
  final bool isLowStock;
  final int? minStock;
  final String sku;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.category,
    required this.isLowStock,
    required this.sku,
    this.minStock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: json['price']?.toString() ?? '0',
      image: json['image']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      category: json['category']?.toString() ?? '',
      isLowStock: json['is_low_stock'] ?? false,
      sku: json['sku']?.toString() ?? 'N/A',
      minStock: (json['min_stock'] as num?)?.toInt(),
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      price: price,
      image: image,
      quantity: quantity,
      category: category,
      isLowStock: isLowStock,
      sku: sku,
      minStock: minStock,
    );
  }
}