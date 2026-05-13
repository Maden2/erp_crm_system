import 'package:flutter/material.dart';
import 'package:pivot/core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget title;
  final List<Widget>? actions;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      title: title,
      actions: actions,
      leading: leading,
    );
  }
}