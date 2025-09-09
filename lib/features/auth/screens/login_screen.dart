import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:restaurant/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/helper/my_navigator.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_paddings.dart';
import 'package:restaurant/core/widgets/custom_btn.dart';
import 'package:restaurant/core/widgets/custom_svg.dart';
import 'package:restaurant/core/widgets/custom_text_btn.dart';
import 'package:restaurant/core/widgets/custom_text_form_field.dart';
import 'package:restaurant/features/auth/cubit/login_cubit/login_state.dart';
import 'package:restaurant/features/home/screen/home_screen.dart';

import 'register_screen.dart';
import 'widgets/custom_auth_image.dart';
import 'widgets/custom_q_text.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              MyNavigator.goTo(
                context,
                HomeScreen(),
                type: NavigatorType.pushAndRemoveUntil,
              );
            } else if (state is LoginError) {
              AppPopUp.showSnackBar(state.error, context);
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Column(
              children: [
                // CustomAuthImage(),
                SizedBox(height: 23.h),
                Padding(
                  padding: AppPaddings.horizontalPadding,
                  child: Form(
                    key: cubit.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          validator: AppValidator.emailValidator,
                          controller: cubit.usernameController,
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: CustomSvg(path: AppAssets.person),
                          ),
                          hintText: 'username',
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          validator: AppValidator.passwordValidator,
                          controller: LoginCubit.get(
                            context,
                          ).passwordController,
                          prefixIcon: IconButton(
                            onPressed: null,
                            icon: CustomSvg(path: AppAssets.key),
                          ),
                          hintText: 'password',
                          obscureText: LoginCubit.get(context).passwordSecure,
                          suffixIcon: IconButton(
                            onPressed: LoginCubit.get(
                              context,
                            ).changePasswordVisibility,
                            icon: CustomSvg(
                              path: LoginCubit.get(context).passwordSecure
                                  ? AppAssets.lockIcon
                                  : AppAssets.unlockIcon,
                            ),
                          ),
                        ),

                        SizedBox(height: 23.h),
                        state is LoginLoading
                            ? const CircularProgressIndicator()
                            : CustomBtn(text: 'Login', onPressed: cubit.login),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomQText(text: 'Don\'t have an account?'),
                            SizedBox(width: 8.w),
                            CustomTextBtn(
                              text: 'Register',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
