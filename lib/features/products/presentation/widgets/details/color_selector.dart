import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class ColorSelector extends StatelessWidget {
  final List<int> colors;
  const ColorSelector({super.key, required this.colors});

  String _getColorName(int colorValue) {
    final Color c = Color(colorValue);
    final HSLColor hsl = HSLColor.fromColor(c);

    final double h = hsl.hue;
    final double s = hsl.saturation;
    final double l = hsl.lightness;

    if (l >= 0.9) return 'أبيض';
    if (l <= 0.1) return 'أسود';
    if (s <= 0.1) {
      if (l < 0.4) return 'رمادي داكن';
      if (l < 0.7) return 'رمادي';
      return 'رمادي فاتح';
    }

    if (h < 15 || h >= 345) return 'أحمر';
    if (h < 40) return 'برتقالي';
    if (h < 65) return 'أصفر';
    if (h < 150) {
      if (l < 0.3) return 'أخضر داكن';
      return 'أخضر';
    }
    if (h < 185) return 'تركوازي';
    if (h < 225) {
      if (l < 0.3) return 'أزرق داكن';
      return 'أزرق';
    }
    if (h < 255) {
      if (l < 0.2) return 'نيلي';
      return 'أزرق بنفسجي';
    }
    if (h < 290) return 'بنفسجي';
    if (h < 320) return 'وردي داكن';
    if (h < 345) return 'وردي';

    return 'لون';
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: colors.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lightBlueGrey,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              Container(
                width: 35.w,
                height: 35.h,
                decoration: BoxDecoration(
                  color: Color(colors[index]),
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                _getColorName(colors[index]),
                style: TextStyles.font14graphiteGreyRegular,
              ),
            ],
          ),
        );
      },
    );
  }
}
