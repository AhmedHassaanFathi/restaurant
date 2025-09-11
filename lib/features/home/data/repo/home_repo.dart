import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:restaurant/core/network/api_helper.dart';
import 'package:restaurant/core/network/api_response.dart';
import 'package:restaurant/core/network/end_points.dart';
import 'package:restaurant/features/auth/data/models/login_response_model.dart';
import 'package:restaurant/features/home/data/model/menu_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeRepo
{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, UserModel>> getUser()async
  {
    try{
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isProtected: true
      );
      if(response.status)
      {
        var data = response.data as Map<String, dynamic>;
        LoginResponseModel responseModel =
        LoginResponseModel.fromJson(data);
        return right(responseModel.user!);
      }
      else{
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(e.toString());
    }
  }
  
  


  Future<Either<String, List<CategoryModel>>> getMenu() async
  {
    try
    {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getMenu,
        isProtected: true
      );
      if(response.status)
      {
        MenuResponseModel menu = MenuResponseModel.fromJson(response.data as Map<String, dynamic>);
        return Right(menu.categories!);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}

