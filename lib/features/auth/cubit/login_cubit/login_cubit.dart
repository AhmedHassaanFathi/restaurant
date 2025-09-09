import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/auth/cubit/login_cubit/login_state.dart';
import 'package:restaurant/features/auth/data/repo/auth_repo.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  bool passwordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(ChangePasswordVisibilityState());
  }

  final formKey = GlobalKey<FormState>();
  final AuthRepo repo = AuthRepo();
  void login() async {
    if (!formKey.currentState!.validate()) return;
    emit(LoginLoading());
    var loginResponse = await repo.login(
      email: usernameController.text,
      password: passwordController.text,
    );

    loginResponse.fold(
      (String error) => emit(LoginError(error: error)),
      (userModel) => emit(LoginSuccess()),



    );
  }
}
