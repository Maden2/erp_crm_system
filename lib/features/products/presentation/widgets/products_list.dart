import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import 'product_card.dart';

class ProductsList extends StatelessWidget {
  final List<ProductEntity> products;
  final Function(ProductEntity)? onProductTap;

  const ProductsList({
    super.key,
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () => onProductTap?.call(product),
          child: ProductCard(product: product),
        );
      },
    );
  }
}