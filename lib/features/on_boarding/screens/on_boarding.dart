import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/features/on_boarding/cubit/on_boarding_cubit/on_boarding_cubit.dart';
import 'package:restaurant/features/on_boarding/screens/widgets/on_boarding_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnBoardingCubit(),
      child: BlocBuilder<OnBoardingCubit, int>(
        builder: (context, index) {
          var cubit = OnBoardingCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  // PageView
                  Expanded(
                    child: PageView(
                      controller: cubit.pageController,
                      onPageChanged: cubit.changePage,
                      children: const [
                        OnBoardingItem(
                          image: AppAssets.onBoardingImage1,
                          title: "Order For Food",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          buttonText: "Next",
                        ),
                        OnBoardingItem(
                          image: AppAssets.onBoardingImage2,
                          title: "Easy Payment",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          buttonText: "Next",
                        ),
                        OnBoardingItem(
                          image: AppAssets.onBoardingImage3,
                          title: "Fast Delivery",
                          description:
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.",
                          buttonText: "Get Started",
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
    );
  }
}
