import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserReportAddOperations {
  Future<Either<ErrorModel, bool>> addUserGoals(
      String endPoind, int goal) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;

      Response response = await http.post(Uri.parse(baseUrl + endPoind),
          body: {'goal': goal.toString()},
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 201) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          access = newAccess.right;
          response = await http.post(Uri.parse(baseUrl + endPoind),
              body: {'goal': goal.toString()},
              headers: {'Authorization': 'Bearer $access'});
          if (response.statusCode == 201) {
            return const Right(true);
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session Expired'));
  }

  Future<Either<ErrorModel, bool>> addUserWeights(double weight) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;

      Response response = await http.post(Uri.parse('${baseUrl}users/weight/'),
          body: {'weight': weight.toString()},
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 201) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          access = newAccess.right;
          response = await http.post(Uri.parse('${baseUrl}users/weight/'),
              body: {'weight': weight.toString()},
              headers: {'Authorization': 'Bearer $access'});
          if (response.statusCode == 201) {
            return const Right(true);
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session Expired'));
  }

  Future<Either<ErrorModel, Response>> addTransformationImage(File image) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      StreamedResponse streamedResponse=await transformationImageAddHelper(image, access);
     
      if (streamedResponse.statusCode == 201) {
        Response response = await http.Response.fromStream(streamedResponse);
        return  Right(response);
      } else if (streamedResponse.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          access = newAccess.right;
          streamedResponse =await transformationImageAddHelper(image, access);
          if (streamedResponse.statusCode == 201) {
               Response response = await http.Response.fromStream(streamedResponse);
            return  Right(response);
          }
        }
      }
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('session Expired'));
  }

  Future<StreamedResponse>transformationImageAddHelper(File image,String access)async{
         final request = http.MultipartRequest(
      'POST',
      Uri.parse(baseUrl+transformationImageEndPoint),
    );
      request.headers.addAll({
      'Authorization': 'Bearer $access',
      'Content-type': 'multipart/form-data'
    });
    final pic = await http.MultipartFile.fromPath(
      "image",
      image.path,
    );
    request.files.add(pic);
    StreamedResponse response = await request.send();
    return response;
  }
}
