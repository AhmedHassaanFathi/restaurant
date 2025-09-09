import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/features/auth/data/repo/auth_repo.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  XFile? image;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;

  void changePasswordVisibility() {
    passwordSecure = !passwordSecure;
    emit(RegisterChangePasswordVisibility());
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordSecure = !confirmPasswordSecure;
    emit(RegisterChangeConfirmPasswordVisibility());
  }

  onRegisterPressed() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(RegisterLoading());
    AuthRepo repo = AuthRepo();
    var response = await repo.register(
      phone: phoneController.text,
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      image: image,
    );
    response.fold(
      (String error) => emit(RegisterError(error: error)),
      (userModel) => emit(RegisterSuccess()),
    );
  }
}
