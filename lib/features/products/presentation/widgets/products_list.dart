import 'package:flutter/material.dart';
import '../../domain/entities/website_product_entities.dart'; //[cite: 13]
import 'product_card.dart'; //[cite: 13]

class ProductsList extends StatelessWidget {
  final List<WebsiteProductItemEntity> products; // تحديث الـ Entity الحقيقية[cite: 13]
  final Function(WebsiteProductItemEntity)? onProductTap; //[cite: 13]

  const ProductsList({super.key, required this.products, this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, //[cite: 13]
      physics: const NeverScrollableScrollPhysics(), //[cite: 13]
      itemCount: products.length, //[cite: 13]
      itemBuilder: (context, index) {
        final product = products[index]; //[cite: 13]
        return InkWell(
          onTap: () => onProductTap?.call(product), //[cite: 13]
          child: ProductCard(product: product), //[cite: 13]
        );
      },
    );
  }
}