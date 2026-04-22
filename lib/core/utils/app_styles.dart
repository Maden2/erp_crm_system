import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

class TextStyles {

  static const String fontFamily = 'Cairo';


  static TextStyle font24PrimaryBold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );

  static TextStyle font20DarkGreyMedium = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
    fontFamily: fontFamily,
  );

  static TextStyle font14DarkGreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.darkGrey,
    fontFamily: fontFamily,
  );


  static TextStyle font14GreyRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.grey,
    fontFamily: fontFamily,
  );



  static TextStyle font14WhiteRegular = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.white,
    fontFamily: fontFamily,
  );


  static TextStyle font14PrimaryBold = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );


  static TextStyle font14DarkBlueMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );

  static TextStyle font18DarkBlueBold = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
    fontFamily: fontFamily,
  );


  static TextStyle font16WhiteBold = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontFamily: fontFamily,
  );


  static TextStyle font12RedRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Colors.red,
    fontFamily: fontFamily,
  );

  static TextStyle font12LightGreyRegular = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.lightGrey,
    fontFamily: fontFamily,
  );


  static TextStyle font12DarkGreyRegular = TextStyle(
    fontSize: 11.45.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.darkGrey,
    fontFamily: fontFamily,
  );

  static TextStyle fontNavSelected = TextStyle(
    fontSize: 11.45.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.navSelectedColor,
    fontFamily: fontFamily,
  );

  static TextStyle fontNavUnSelected = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.navUnSelectedColor,
    fontFamily: fontFamily,
  );
}