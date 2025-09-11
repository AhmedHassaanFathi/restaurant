import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/features/auth/screens/login_screen.dart';
import 'package:restaurant/features/auth/screens/register_screen.dart';
import 'package:restaurant/features/auth/screens/widgets/action_button_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE95322),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 95.w),
        child: Column(
          children: [
            SizedBox(height: 250.h),

            SvgPicture.asset(
              AppAssets.logo,
              height: 178.9466094970703.h,
              width: 202.w,
              color: Color(0xffF5CB58),
            ),
            SizedBox(height: 26.h),
            SvgPicture.asset(
              AppAssets.yumquick,
              height: 52.h,
              width: 195.w,
              color: Color(0xffF5CB58),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "Order food from our restaurant and\nmake reservation in real time",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 43.h),
            ActionButton(
              width: 207.w,
              height: 45.h,
              borderRadius: 30.r,
              text: 'Log In',
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4A00),
              ),
              // solid peach color
              color: Color(0xFFF6C061),
              onPressed: () {
                AppNavigator.goTo(context, LoginScreen());
                // هنا تحط الاكشن اللي تحب: navigation، فتح صفحة، دالة...
                // مثال: Navigator.pushNamed(context, '/login');
                print('Log In pressed');
              },
            ),

            SizedBox(height: 4.h),

            // Sign Up button (light cream fill, orange text)
            ActionButton(
              width: 207.w,
              height: 45.h,
              borderRadius: 30.r,
              text: 'Sign Up',
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFFEF4A00),
              ),
              color: Color(0xFFF6E9C8),
              onPressed: () {
                AppNavigator.goTo(context, RegisterScreen());
                print('Sign Up pressed');
                // مثال: Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
