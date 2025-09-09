
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterChangePasswordVisibility extends RegisterState {}

class RegisterChangeConfirmPasswordVisibility extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  String error;
  RegisterError({required this.error});
}
