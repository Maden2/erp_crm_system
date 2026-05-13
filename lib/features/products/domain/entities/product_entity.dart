class ProductEntity {
  final String id;
  final String name;
  final String price;
  final String image;
  final int quantity;
  final String category;
  final bool isLowStock;
  final int? minStock;
  final String sku;

  ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.category,
    required this.isLowStock,
    this.sku = "غير متوفر",
    this.minStock,
  });
}