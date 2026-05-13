import 'package:equatable/equatable.dart';

class ProductDetailsEntity extends Equatable {
  final String id;
  final String name;
  final String price;
  final String sku;
  final String brand;
  final int stock;
  final int warranty;
  final String description;
  final List<String> images;
  final List<int> colors;
  final List<String> sizes;
  final List<double> priceHistory;
  final String category;
  final int minOrder;

  const ProductDetailsEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.sku,
    required this.brand,
    required this.stock,
    required this.warranty,
    required this.description,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.priceHistory,
    required this.category,
    required this.minOrder,
  });

  @override
  List<Object?> get props => [
    id,
    sku,
    name,
    priceHistory,
    stock,
    price,
  ];
}