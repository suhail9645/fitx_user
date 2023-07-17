import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_add_prime.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddToPrimeRepo {
  Future<Either<ErrorModel, bool>> addUserPrime() async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      final errorOrResponse = await UserAddPrime().addUserToPremium();
      if (errorOrResponse.isRight) {
        Response response = errorOrResponse.right;
        final data = jsonDecode(response.body);
        await shrd.setString('user', data);
        return const Right(true);
      }else{
        return Left(errorOrResponse.left);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
