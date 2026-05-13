import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/utils/app_styles.dart';
import 'products_search_delegate.dart';

class ProductsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function(String)? onSearch;
  final Function(String)? onFilter;

  const ProductsAppBar({
    super.key,
    this.onSearch,
    this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Text("المنتجات", style: TextStyles.font20WhiteMedium),
      leading: IconButton(
        icon: Icon(Icons.tune, color: AppColors.homeBg, size: 24.sp),
        onPressed: () => _showFilter(context),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: AppColors.homeBg, size: 24.sp),
          onPressed: () => _showSearch(context),
        ),
      ],
    );
  }

  void _showSearch(BuildContext context) {
    showSearch(
      context: context,
      delegate: ProductsSearchDelegate(onSearch),
    );
  }

  void _showFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ListTile(
        title: const Text("موبايلات"),
        onTap: () {
          onFilter?.call("موبايلات");
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}