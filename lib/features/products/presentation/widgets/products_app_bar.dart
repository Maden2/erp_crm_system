import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/utils/app_styles.dart';
import 'products_search_delegate.dart';

class ProductsAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String)? onSearch; //[cite: 11]
  final Function(String)? onFilter; //[cite: 11]

  const ProductsAppBar({super.key, this.onSearch, this.onFilter});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text("المنتجات", style: TextStyles.font20WhiteMedium), //[cite: 11]
      leading: IconButton(
        icon: Icon(Icons.tune, color: AppColors.homeBg, size: 24.sp), //[cite: 11]
        onPressed: () => _showFilter(context), //[cite: 11]
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.homeBg, size: 24.sp), //[cite: 11]
          onPressed: () => _showSearch(context), //[cite: 11]
        ),
      ],
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(context: context, delegate: ProductsSearchDelegate(onSearch)); //[cite: 11]
  }

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListTile(
        title: const Text("موبايلات"), //[cite: 11]
        onTap: () {
          onFilter?.call("موبايلات"); //[cite: 11]
          Navigator.pop(context); //[cite: 11]
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h); //[cite: 11]
}