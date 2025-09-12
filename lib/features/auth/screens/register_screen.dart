import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_pop_up.dart';
import 'package:restaurant/core/helper/app_validator.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/widgets/custom_text_form_field.dart';
import 'package:restaurant/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:restaurant/features/auth/cubit/register_cubit/register_state.dart';
import 'package:restaurant/features/auth/screens/widgets/top_text_widget.dart';

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
                    
                    const TopText(text: "New Account"),
                    
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
                             
                                SizedBox(height: 20.h),
                                Text(
                                  " Full name",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: cubit.nameController,
                                  // prefixIcon: null,
                                  hintText: "Enter name here",
                                  validator: AppValidator.nameValidator,
                                ),
                                SizedBox(height: 10.h),
                                // Email field
                                Text(
                                  " Email",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: cubit.emailController,
                                  // prefixIcon: null,
                                  hintText: "Enter email here",
                                  validator: AppValidator.emailValidator,
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(height: 10.h),

                                Text(
                                  " Mobile Number",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                                CustomTextFormField(
                                  controller: cubit.phoneController,
                                  hintText: "Enter mobile number here",
                                  validator: AppValidator.phoneValidator,
                                ),
                                Text(
                                  " Password",
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
                                SizedBox(height: 10.h),

                                Text(
                                  " Confirm Password",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
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
                                      onPressed: () {
                                        cubit.onRegisterPressed();
                                      },
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
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          // color: Colors.white,
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
