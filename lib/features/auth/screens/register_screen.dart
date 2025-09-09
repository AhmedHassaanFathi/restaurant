import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_paddings.dart';
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

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});
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
            return Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // CustomAuthImage(),
                    ImageManagerView(
                      onImagePicked: (image) =>
                          RegisterCubit.get(context).image = image,
                      imageBuilder: (image) {
                        return CustomAuthImage(
                          image: FileImage(File(image.path)),
                        );
                      },
                      defaultBuilder: CustomAuthImage(),
                    ),
                    SizedBox(height: 23.h),
                    Padding(
                      padding: AppPaddings.horizontalPadding,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            validator: AppValidator.phoneValidator,
                            controller: RegisterCubit.get(
                              context,
                            ).phoneController,
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.call),
                            ),
                            hintText: 'Phone Number',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: AppValidator.requiredValidator,
                            controller: RegisterCubit.get(
                              context,
                            ).nameController,
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: Icon(Icons.title),
                            ),
                            hintText: 'Name',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: AppValidator.emailValidator,
                            controller: RegisterCubit.get(
                              context,
                            ).emailController,
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: CustomSvg(path: AppAssets.person),
                            ),
                            hintText: 'username',
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: AppValidator.passwordValidator,
                            controller: RegisterCubit.get(
                              context,
                            ).passwordController,
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: CustomSvg(path: AppAssets.key),
                            ),
                            hintText: 'password',
                            obscureText: RegisterCubit.get(
                              context,
                            ).passwordSecure,
                            suffixIcon: IconButton(
                              onPressed: RegisterCubit.get(
                                context,
                              ).changePasswordVisibility,
                              icon: CustomSvg(
                                path: RegisterCubit.get(context).passwordSecure
                                    ? AppAssets.lockIcon
                                    : AppAssets.unlockIcon,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomTextFormField(
                            validator: (value) =>
                                AppValidator.confirmPasswordValidator(
                                  value,
                                  cubit.passwordController.text,
                                ),
                            controller: RegisterCubit.get(
                              context,
                            ).confirmPasswordController,
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: CustomSvg(path: AppAssets.key),
                            ),
                            hintText: 'confirm password',
                            obscureText: RegisterCubit.get(
                              context,
                            ).confirmPasswordSecure,
                            suffixIcon: IconButton(
                              onPressed: RegisterCubit.get(
                                context,
                              ).changeConfirmPasswordVisibility,
                              icon: CustomSvg(
                                path:
                                    RegisterCubit.get(
                                      context,
                                    ).confirmPasswordSecure
                                    ? AppAssets.lockIcon
                                    : AppAssets.unlockIcon,
                              ),
                            ),
                          ),
                          SizedBox(height: 23.h),
                          // check if state is loading show loading
                          state is RegisterLoading
                              ? CircularProgressIndicator()
                              : CustomBtn(
                                  text: 'Register',
                                  onPressed: RegisterCubit.get(
                                    context,
                                  ).onRegisterPressed,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomQText(text: 'Already have an account?'),
                              SizedBox(width: 8.w),
                              CustomTextBtn(text: 'Login', onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
