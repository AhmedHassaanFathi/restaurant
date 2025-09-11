import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';

abstract class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

abstract class AppStyles {
  static TextStyle styleLarge28 = TextStyle(
    fontSize: 28.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );
  static TextStyle styleMedium16 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleMedium12 = TextStyle(
    fontSize: 12.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );

  static TextStyle styleRegular24 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular15 = TextStyle(
    fontSize: 15.sp,
    color: AppColors.primary,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular12 = TextStyle(
    fontSize: 12.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleRegular12Gray = TextStyle(
    fontSize: 12.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w400,
  );
  static TextStyle styleMedium12Gray = TextStyle(
    fontSize: 12.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleExtraLight14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w200,
  );
  static TextStyle styleLight19 = TextStyle(
    fontSize: 19.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w300,
  );
  static TextStyle styleLight16 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
  );
  static TextStyle styleLight14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
  );
  static TextStyle styleLight14Black = TextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w300,
  );
  static TextStyle styleMedium14Black = TextStyle(
    fontSize: 14.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleLight12 = TextStyle(
    fontSize: 12.sp,
    color: AppColors.grey,
    fontWeight: FontWeight.w300,
  );
  static TextStyle styleMedium40 = TextStyle(
    fontSize: 40.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );
  static TextStyle styleMedium24 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );
}

