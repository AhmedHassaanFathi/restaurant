import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';


class CustomQText extends StatelessWidget {
  const CustomQText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: AppFontWeight.extraLight,
      ),
    );
  }
}
