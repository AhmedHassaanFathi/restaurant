import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/utils/app_colors.dart';

import 'package:restaurant/features/auth/cubit/login_cubit/login_cubit.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/core/widgets/custom_text_form_field.dart';
import 'package:restaurant/features/auth/cubit/login_cubit/login_state.dart';
import 'package:restaurant/features/auth/screens/widgets/top_text_widget.dart';
import 'package:restaurant/features/home/screen/home_screen.dart';


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
     
                    TopText(
                      text: "Hello!",
                    ),

          
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
                                Text(
                                  "Welcome",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20.h),

                                // Email field
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
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
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
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
                                    width: 207.w,
                                    height: 45.h,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        cubit.login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepOrange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
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

            
          },
        ),
      ),
    );
  }
}

