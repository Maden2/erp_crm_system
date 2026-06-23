import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class AppTextField extends StatefulWidget {
  final String label;
  final String hintText;

  final Widget? prefixIcon;

  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
    this.errorText,
    this.focusNode,
    this.keyboardType,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;
    final bool isFocused = widget.focusNode?.hasFocus ?? false;

    Color currentBorderColor() {
      if (hasError) return AppColors.danger;
      if (isFocused) return AppColors.borderColorSelected;
      return AppColors.borderColor;
    }

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,

      obscureText: widget.isPassword ? isObscure : false,

      style: TextStyles.font12DarkGreyRegular,

      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,

      decoration: InputDecoration(
        labelText: widget.label,
        alignLabelWithHint: true,

        labelStyle: TextStyles.font14PrimaryBold.copyWith(
          color: currentBorderColor(),
        ),

        hintText: widget.hintText,
        hintStyle: TextStyles.font14GreyRegular,

        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: EdgeInsetsDirectional.only(start: 12.w),
                child: IconTheme(
                  data: IconThemeData(color: AppColors.grey),
                  child: widget.prefixIcon!,
                ),
              )
            : null,

        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.grey,
                  size: 24.sp,
                ),
              )
            : null,

        errorText: widget.errorText,
        errorStyle: TextStyles.font12redRegular,

        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: AppColors.borderColorSelected,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.danger),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: const BorderSide(color: AppColors.danger, width: 1.5),
        ),
      ),
    );
  }
}
