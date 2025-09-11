// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:restaurant/core/network/api_helper.dart';
import 'package:restaurant/core/network/api_response.dart';
import 'package:restaurant/core/network/end_points.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant/features/auth/data/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );
      if (response.status) {
        LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
          'access_token',
          loginResponseModel.accessToken!,
        );
        sharedPreferences.setString(
          'refresh_token',
          loginResponseModel.refreshToken!,
        );

        return Right(loginResponseModel.user!);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String, Unit>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      };

      // If image exists, attach as file
      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: data,
      );
      if (response.status) {
        return right(unit);
      } else {
        return left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }

    // Future<Either<String, Unit>> logout() async {
    //   try {
    //     await apiHelper.postRequest(
    //       endPoint: EndPoints.logout,
    //     );
    //     return right(unit);
    //   } catch (e) {
    //     print(e);
    //     return Left(ApiResponse.fromError(e).message);
    //   }
    // }
  }
}
