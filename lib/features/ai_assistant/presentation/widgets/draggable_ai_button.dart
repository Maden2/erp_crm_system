import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DraggableAiButton extends StatefulWidget {
  final VoidCallback onTap;
  const DraggableAiButton({super.key, required this.onTap});

  @override
  State<DraggableAiButton> createState() => _DraggableAiButtonState();
}

class _DraggableAiButtonState extends State<DraggableAiButton> {
  // الأبعاد الافتراضية المبدئية لظهور الزرار (أسفل اليسار)
  double xPosition = 20.0;
  double yPosition = 120.0;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    // حجم الزرار المظبوط بالشاشة
    final double buttonSize = 56.w;

    return Positioned(
      left: xPosition,
      bottom: yPosition,
      child: GestureDetector(
        onPanStart: (_) => setState(() => isDragging = true),
        onPanUpdate: (details) {
          setState(() {
            // تحديث الإحداثيات مع حركة الـ إصبع
            xPosition += details.delta.dx;
            yPosition -= details.delta.dy; // قلبنا الإشارة لأننا شغالين من الـ bottom

            // 🛡️ Boundary Check: منع الزرار يخرج برا حدود العرض يمين وشمال
            if (xPosition < 16) xPosition = 16;
            if (xPosition > screenWidth - buttonSize - 16) {
              xPosition = screenWidth - buttonSize - 16;
            }

            // 🛡️ Boundary Check: منع الزرار يخرج برا حدود الارتفاع فوق وتحت
            if (yPosition < 80) yPosition = 80; // فوق الـ Bottom NavBar
            if (yPosition > screenHeight - buttonSize - 60) {
              yPosition = screenHeight - buttonSize - 60;
            }
          });
        },
        onPanEnd: (_) => setState(() => isDragging = false),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: isDragging ? 0.7 : 1.0, // شفافية خفيفة أثناء السحب لزيادة التفاعل
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2563EB), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.4),
                  blurRadius: 12.r,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: widget.onTap,
                child: Center(
                  child: Icon(
                    Icons.psychology_outlined, // أيقونة الـ AI الذكي الرايقة
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}