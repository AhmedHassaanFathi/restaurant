import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          shadowColor: AppColors.primary,
          elevation: 10,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 19.sp,
            fontWeight: AppFontWeight.light,
          ),
        ),
      ),
    );
  }
}
