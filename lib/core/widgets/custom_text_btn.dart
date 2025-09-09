import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';


class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: AppFontWeight.regular,
          fontSize: 14.sp,
          color: AppColors.black,
        ),
      ),
    );
  }
}
