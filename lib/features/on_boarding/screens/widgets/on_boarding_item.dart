import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/features/auth/screens/welcome_screen.dart';
import 'package:restaurant/features/on_boarding/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;

  const OnBoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = OnBoardingCubit.get(context);
    var index = cubit.state;

    return Stack(
      children: [
        // الخلفية (الصورة)
        SizedBox.expand(child: Image.asset(image, fit: BoxFit.cover)),

        // الكونتينر الأبيض تحت
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.fastfood, color: Colors.deepOrange, size: 40),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.deepOrange,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20),
                //     ),
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                //   ),
                //   onPressed: () {
                //     if (buttonText == "Next") {
                //       cubit.nextPage();
                //     } else {
                //       // Navigate to Home or Login
                //     }
                //   },
                //   child: Text(buttonText),
                // ),
                // if (index < 2)
                //   TextButton(
                //     onPressed: cubit.skip,
                //     child: const Text("Skip"),
                //   ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SmoothPageIndicator(
                        controller: cubit.pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: Colors.deepOrange,
                          dotColor: Colors.grey.shade400,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        onPressed: () {
                          if (index < 2) {
                            cubit.nextPage();
                          } else {
                            AppNavigator.goTo(context, WelcomeScreen());
                          }
                        },
                        child: Text(index == 2 ? "Get Started" : "Next"),
                      ),
                      if (index < 2)
                        TextButton(
                          onPressed: () => cubit.skip(context),
                          child: const Text("Skip"),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
