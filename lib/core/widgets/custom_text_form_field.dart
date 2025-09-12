import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    this.obscureText = false,
    this.validator,
  });

  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      style: TextStyle(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
                                  fillColor: const Color(0xFFF6E9C8),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          color: AppColors.grey,
        ),
        border: borderBuilder(),
        enabledBorder: borderBuilder(),
        focusedBorder: borderBuilder(color: AppColors.primary),
        focusedErrorBorder: borderBuilder(color: AppColors.primary),
        errorBorder: borderBuilder(color: AppColors.red),
      ),
    );
  }

  InputBorder borderBuilder({Color color = const Color(0xFFF6E9C8)}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: color),
      );
}
