import 'package:restaurant/features/profile/data/model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileDataSuccess extends ProfileState {
  List<UserModel> Userdata;
  ProfileDataSuccess({required this.Userdata});
}

class ProfileDataError extends ProfileState {
  String message;
  ProfileDataError({required this.message});
}

class ProfileDataLoading extends ProfileState {}
