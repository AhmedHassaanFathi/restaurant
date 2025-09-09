import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/core/helper/wrapper_svg.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_paddings.dart';
import 'package:restaurant/features/on_boarding/screens/on_boarding.dart';



class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  // void initState() {
  //    super.initState();
  //   // بعد 3 ثواني يروح للصفحة التالية
  //   Timer(const Duration(seconds: 3), () {
  //   });
  // }
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {

      AppNavigator.goTo(context, OnBoarding(), type: NavigatorType.pushReplacement);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: AppPaddings.horizontalPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          SvgImage.asset(
            AppAssets.logo,
            width: 202.w,
            height: 179.h,
          ),
          SvgImage.asset(
            AppAssets.yumquick,
            width: 202.w,
            height: 179.h,
          ),
        ],
          ),
        ),
      ),
    );
  }
}
