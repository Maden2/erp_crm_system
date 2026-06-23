import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pivot/core/utils/app_colors.dart';
import 'package:pivot/core/utils/app_styles.dart';

class ProductImageSlider extends StatefulWidget {
  final List<String> images;

  const ProductImageSlider({super.key, required this.images});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 419.h,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return Image.network(
                widget.images[index],
                fit: BoxFit.cover,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, color: Colors.grey),
              );
            },
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 17.w,
            right: 17.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFloatingButton(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 55.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                bool isActive = _currentIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  width: isActive ? 22.w : 7.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary
                        : Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                );
              }),
            ),
          ),

          Positioned(
            bottom: 55.h,
            left: 16.w,
            child: Icon(
              Icons.fullscreen_rounded,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),

          Positioned(
            bottom: 55.h,
            right: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFFDDE3F9),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.history, color: AppColors.primary, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text("السجل", style: TextStyles.font14PrimaryRegular),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.r),
        child: Icon(icon, color: AppColors.primary, size: 17.sp),
      ),
    );
  }
}
