import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/features/home/screen/home_screen.dart';
import 'package:restaurant/features/launch/launch_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (context, widget) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'YUM Quick',
        theme: ThemeData(scaffoldBackgroundColor: Color(0xffF5CB58)),
        // home: HomeScreen(),
        home: LaunchScreen(),
      ),
    );
  }
}
