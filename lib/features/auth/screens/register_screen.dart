import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_paddings.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';
import 'package:restaurant/core/widgets/custom_btn.dart';
import 'package:restaurant/core/widgets/custom_svg.dart';
import 'package:restaurant/core/widgets/custom_text_btn.dart';
import 'package:restaurant/core/widgets/custom_text_form_field.dart';
import 'package:restaurant/core/widgets/image_manager/image_manager_view.dart';
import 'package:restaurant/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:restaurant/features/auth/cubit/register_cubit/register_state.dart';
import 'login_screen.dart';
import 'widgets/custom_auth_image.dart';
import 'widgets/custom_q_text.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              AppPopUp.showSnackBar('Register Success', context);
            } else if (state is RegisterError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          builder: (context, state) {
            var cubit = RegisterCubit.get(context);
            return SafeArea(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    // --------- الجزء العلوي (Hello!) ----------
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: SizedBox(
                        height: 161.h,
                        child: Center(
                          child: Text(
                            "New Account",
                            style: AppStyles.styleLarge28 as TextStyle?,
                          ),
                        ),
                      ),
                    ),

                    // --------- الجزء الأبيض (Card) ----------
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.r),
                            topRight: Radius.circular(40.r),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Welcome text
                                // const Text(
                                //   "New Account",
                                //   style: TextStyle(
                                //     fontSize: 22,
                                //     fontWeight: FontWeight.bold,
                                //     color: Colors.brown,
                                //   ),
                                // ),
                                SizedBox(height: 20.h),
                                Text(
                                  " Full name",
                                  style: AppStyles.styleMedium24 as TextStyle?,
                                ),
                                CustomTextFormField(
                                  controller: cubit.emailController,
                                  // prefixIcon: null,
                                  hintText: "Enter email here",
                                  validator: AppValidator.emailValidator,
                                ),
                                SizedBox(height: 10.h),
                                // Email field
                                Text(
                                  " Email",
                                  style: AppStyles.styleMedium24 as TextStyle?,
                                ),
                                CustomTextFormField(
                                  controller: cubit.emailController,
                                  // prefixIcon: null,
                                  hintText: "Enter email here",
                                  validator: AppValidator.emailValidator,
                                ),
                                // SizedBox(height: 10.h),
                                SizedBox(height: 10.h),

                                Text(
                                  " Mobile Number",
                                  style: AppStyles.styleMedium24 as TextStyle?,
                                ),
                                CustomTextFormField(
                                  controller: cubit.phoneController,
                                  hintText: "Enter mobile number here",
                                  validator: AppValidator.phoneValidator,
                                ),
                                Text(
                                  " Password",
                                  style: AppStyles.styleMedium24 as TextStyle?,
                                ),
                                CustomTextFormField(
                                  controller: cubit.passwordController,

                                  // prefixIcon: null,
                                  obscureText: cubit.passwordSecure,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () {
                                      cubit.changePasswordVisibility();
                                    },
                                  ),
                                  hintText: "Enter Password here",
                                  validator: AppValidator.passwordValidator,
                                ),
                                SizedBox(height: 10.h),

                                Text(
                                  " Confirm Password",
                                  style: AppStyles.styleMedium24 as TextStyle?,
                                ),
                                CustomTextFormField(
                                  controller: cubit.confirmPasswordController,

                                  // prefixIcon: null,
                                  obscureText: cubit.confirmPasswordSecure,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.visibility_off,
                                      color: AppColors.primary,
                                    ),
                                    onPressed: () {
                                      cubit.changeConfirmPasswordVisibility();
                                    },
                                  ),
                                  hintText: "Enter Confirm Password here",
                                  validator: AppValidator.passwordValidator,
                                ),
                                SizedBox(height: 60.h),

                                // Log In button
                                Center(
                                  child: SizedBox(
                                    width: 207,
                                    height: 45,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Sign Up",
                                        style:
                                            AppStyles.styleMedium24
                                                as TextStyle?,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            // return Form(
            //   key: cubit.formKey,
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         // CustomAuthImage(),
            //         ImageManagerView(
            //           onImagePicked: (image) =>
            //               RegisterCubit.get(context).image = image,
            //           imageBuilder: (image) {
            //             return CustomAuthImage(
            //               image: FileImage(File(image.path)),
            //             );
            //           },
            //           defaultBuilder: CustomAuthImage(),
            //         ),
            //         SizedBox(height: 23.h),
            //         Padding(
            //           padding: AppPaddings.horizontalPadding,
            //           child: Column(
            //             children: [
            //               CustomTextFormField(
            //                 validator: AppValidator.phoneValidator,
            //                 controller: RegisterCubit.get(
            //                   context,
            //                 ).phoneController,
            //                 prefixIcon: IconButton(
            //                   onPressed: null,
            //                   icon: Icon(Icons.call),
            //                 ),
            //                 hintText: 'Phone Number',
            //               ),
            //               SizedBox(height: 10.h),
            //               CustomTextFormField(
            //                 validator: AppValidator.requiredValidator,
            //                 controller: RegisterCubit.get(
            //                   context,
            //                 ).nameController,
            //                 prefixIcon: IconButton(
            //                   onPressed: null,
            //                   icon: Icon(Icons.title),
            //                 ),
            //                 hintText: 'Name',
            //               ),
            //               SizedBox(height: 10.h),
            //               CustomTextFormField(
            //                 validator: AppValidator.emailValidator,
            //                 controller: RegisterCubit.get(
            //                   context,
            //                 ).emailController,
            //                 prefixIcon: IconButton(
            //                   onPressed: null,
            //                   icon: CustomSvg(path: AppAssets.person),
            //                 ),
            //                 hintText: 'username',
            //               ),
            //               SizedBox(height: 10.h),
            //               CustomTextFormField(
            //                 validator: AppValidator.passwordValidator,
            //                 controller: RegisterCubit.get(
            //                   context,
            //                 ).passwordController,
            //                 prefixIcon: IconButton(
            //                   onPressed: null,
            //                   icon: CustomSvg(path: AppAssets.key),
            //                 ),
            //                 hintText: 'password',
            //                 obscureText: RegisterCubit.get(
            //                   context,
            //                 ).passwordSecure,
            //                 suffixIcon: IconButton(
            //                   onPressed: RegisterCubit.get(
            //                     context,
            //                   ).changePasswordVisibility,
            //                   icon: CustomSvg(
            //                     path: RegisterCubit.get(context).passwordSecure
            //                         ? AppAssets.lockIcon
            //                         : AppAssets.unlockIcon,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 10.h),
            //               CustomTextFormField(
            //                 validator: (value) =>
            //                     AppValidator.confirmPasswordValidator(
            //                       value,
            //                       cubit.passwordController.text,
            //                     ),
            //                 controller: RegisterCubit.get(
            //                   context,
            //                 ).confirmPasswordController,
            //                 prefixIcon: IconButton(
            //                   onPressed: null,
            //                   icon: CustomSvg(path: AppAssets.key),
            //                 ),
            //                 hintText: 'confirm password',
            //                 obscureText: RegisterCubit.get(
            //                   context,
            //                 ).confirmPasswordSecure,
            //                 suffixIcon: IconButton(
            //                   onPressed: RegisterCubit.get(
            //                     context,
            //                   ).changeConfirmPasswordVisibility,
            //                   icon: CustomSvg(
            //                     path:
            //                         RegisterCubit.get(
            //                           context,
            //                         ).confirmPasswordSecure
            //                         ? AppAssets.lockIcon
            //                         : AppAssets.unlockIcon,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 23.h),
            //               // check if state is loading show loading
            //               state is RegisterLoading
            //                   ? CircularProgressIndicator()
            //                   : CustomBtn(
            //                       text: 'Register',
            //                       onPressed: RegisterCubit.get(
            //                         context,
            //                       ).onRegisterPressed,
            //                     ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   CustomQText(text: 'Already have an account?'),
            //                   SizedBox(width: 8.w),
            //                   CustomTextBtn(text: 'Login', onPressed: () {}),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
