import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_report_add.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_t_image_delete.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:http/http.dart';

class UserImageRepo {
  Future<Either<ErrorModel, TImage>> addUserTransformationImage(
      File image) async {
    try {
      final eitherResponse =
          await UserReportAddOperations().addTransformationImage(image);
      if (eitherResponse.isRight) {
        Response response = eitherResponse.right;
        Map<String, dynamic> data = jsonDecode(response.body);
        TImage image = TImage.fromJson(data);
        return Right(image);
      } else {
        return Left(eitherResponse.left);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }

  Future<Either<ErrorModel, bool>> transformationImageDelete(int id) async {
    try {
      final boolOrError = await TImageDeleteOperation().deleteTImage(id);
      if (boolOrError.isRight) {
        return const Right(true);
      } else {
        return Left(boolOrError.left);
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
