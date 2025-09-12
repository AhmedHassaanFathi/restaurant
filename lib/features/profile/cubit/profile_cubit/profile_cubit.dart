import 'package:dartz/dartz.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/features/profile/cubit/profile_cubit/profile_state.dart';
import 'package:restaurant/features/profile/data/model/profile_model.dart';
import 'package:restaurant/features/profile/data/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getProfile() async {
    try {
      emit(ProfileDataLoading());

      Either<String, List<UserModel>> result = await ProfileRepo.getinstance()
          .UserData();

      result.fold(
        (failureMessage) {
          emit(ProfileDataError(message: failureMessage));
        },
        (userData) {
          if (userData.isEmpty || userData[0].user == null) {
            emit(ProfileDataError(message: "Not found"));
            return;
          }

          emit(ProfileDataSuccess(Userdata: userData));
        },
      );
    } catch (e) {
      emit(ProfileDataError(message: "error ${e.toString()}"));
    }
  }
}
