import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class ProductDescriptionSection extends StatelessWidget {
  final String description;
  const ProductDescriptionSection({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          description,
          textDirection: TextDirection.rtl,
          style: TextStyles.font14graphiteGreyRegular
        ),
      ],
    );
  }
}