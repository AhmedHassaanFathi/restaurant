import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';

import 'package:restaurant/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
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

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              AppNavigator.goTo(
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
                            "Hello!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    // --------- الجزء الأبيض (Card) ----------
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Welcome text
                                const Text(
                                  "Welcome",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown,
                                  ),
                                ),
                                const SizedBox(height: 20),
                
                                // Email field
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: cubit.usernameController,
                                  // prefixIcon: null,
                                  hintText: "Enter email here",
                                  validator: AppValidator.emailValidator,
                                ),
                                SizedBox(height: 10.h),
                
                                Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
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
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: const Text(
                                        "Log In",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
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

            //  Column(
            //   children: [
            //     // CustomAuthImage(),
            //     SizedBox(height: 23.h),
            //     Padding(
            //       padding: AppPaddings.horizontalPadding,
            //       child: Form(
            //         key: cubit.formKey,
            //         child: Column(
            //           children: [
            //             CustomTextFormField(
            //               validator: AppValidator.emailValidator,
            //               controller: cubit.usernameController,
            //               prefixIcon: IconButton(
            //                 onPressed: null,
            //                 icon: CustomSvg(path: AppAssets.person),
            //               ),
            //               hintText: 'username',
            //             ),
            //             SizedBox(height: 10.h),
            //             CustomTextFormField(
            //               validator: AppValidator.passwordValidator,
            //               controller: LoginCubit.get(
            //                 context,
            //               ).passwordController,
            //               prefixIcon: IconButton(
            //                 onPressed: null,
            //                 icon: CustomSvg(path: AppAssets.key),
            //               ),
            //               hintText: 'password',
            //               obscureText: LoginCubit.get(context).passwordSecure,
            //               suffixIcon: IconButton(
            //                 onPressed: LoginCubit.get(
            //                   context,
            //                 ).changePasswordVisibility,
            //                 icon: CustomSvg(
            //                   path: LoginCubit.get(context).passwordSecure
            //                       ? AppAssets.lockIcon
            //                       : AppAssets.unlockIcon,
            //                 ),
            //               ),
            //             ),

            //             SizedBox(height: 23.h),
            //             state is LoginLoading
            //                 ? const CircularProgressIndicator()
            //                 : CustomBtn(text: 'Login', onPressed: cubit.login),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 CustomQText(text: 'Don\'t have an account?'),
            //                 SizedBox(width: 8.w),
            //                 CustomTextBtn(
            //                   text: 'Register',
            //                   onPressed: () {
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                         builder: (context) => const RegisterView(),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // );
          },
        ),
      ),
    );
  }
}
