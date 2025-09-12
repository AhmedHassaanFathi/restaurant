import 'package:dartz/dartz.dart';
import 'package:restaurant/core/network/api_helper.dart';
import 'package:restaurant/core/network/api_response.dart';
import 'package:restaurant/core/network/end_points.dart';
import 'package:restaurant/features/profile/data/model/profile_model.dart';

class ProfileRepo{
  ProfileRepo._internal();

  static ProfileRepo instance = ProfileRepo._internal();

  static getinstance() {
    return instance;
  }

  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, List<UserModel>>> UserData() async {
    ApiResponse response = await apiHelper.getRequest(
      endPoint: EndPoints.getUserData,
      data: {
        "user":UserModel().user
      },
      isAuthorized: true,
    );

    if (response.data == null || response.data is! Map<String, dynamic>) {
      return left("Invalid response format");
    }

    try {
      UserModel userdata = UserModel.fromJson(response.data!);
      if (userdata.user == null) {
        return left("No user available");
      }
      return right([userdata]);
    } catch (e) {
      return left("Data parsing failed: ${e.toString()}");
    }
  }

}