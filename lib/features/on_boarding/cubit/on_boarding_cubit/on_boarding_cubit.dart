import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/core/helper/app_navigator.dart';
import 'package:restaurant/features/auth/screens/welcome_screen.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  static OnBoardingCubit get(BuildContext context) =>
    BlocProvider.of<OnBoardingCubit>(context);

  PageController pageController = PageController();

  void changePage(int index) {
    emit(index);
  }

  void nextPage() {
    if (state < 2) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    }
  }

  void skip(BuildContext context) {
    AppNavigator.goTo(context, WelcomeScreen());
  }
}