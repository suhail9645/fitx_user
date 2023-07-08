import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/access_key/get_new_access_key.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../presentation/constants/strings.dart';

class CategoryExerciseOperations {
  Future<Either<ErrorModel, Response>> getCategoryExercise(
    int id,
  ) async {
    try {
      SharedPreferences shrd = await SharedPreferences.getInstance();
      String access = shrd.getString('accessKey')!;
      Response exerciseResponse = await http
          .get(Uri.parse('${baseUrl}exercise/category/$id/'), headers: {
        'Authorization': 'Bearer $access',
      });
      if (exerciseResponse.statusCode == 200) {
        return Right(exerciseResponse);
      } else if (exerciseResponse.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          exerciseResponse = await http
              .get(Uri.parse('${baseUrl}exercise/category/$id/'), headers: {
            'Authorization': 'Bearer ${newAccess.right}',
          });
          if (exerciseResponse.statusCode == 200) {
            return Right(exerciseResponse);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('Session Expired'));
  }

  Future<Either<ErrorModel, Response>> categoryExerciseNextPage(
      String nextPageUrl) async {
    try {
      SharedPreferences shred = await SharedPreferences.getInstance();
      String access = shred.getString('accessKey')!;
      Response response = await http.get(Uri.parse(nextPageUrl),
          headers: {'Authorization': 'Bearer $access'});
      if (response.statusCode == 200) {
        return Right(response);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.get(Uri.parse(nextPageUrl),
              headers: {'Authorization': 'Bearer ${newAccess.right}'});
          if (response.statusCode == 200) {
            return Right(response);
          }
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }
    return Left(ErrorModel('something wrong'));
  }

  Future<Either<ErrorModel, bool>> addToCompletedExercise(
      int categoryId, int exerciseId) async {
    try {
      SharedPreferences shred = await SharedPreferences.getInstance();
      String access = shred.getString('accessKey')!;
      Response response = await http
          .post(Uri.parse('${baseUrl}exercise/completed/'), body: {
        'category_id': categoryId.toString(),
        'exercise_id': exerciseId.toString()
      }, headers: {
        'Authorization': 'Bearer $access'
      });
      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 401) {
        final newAccess = await GetNewAccessKey.getNewAccessKey();
        if (newAccess.isRight) {
          response = await http.post(Uri.parse('${baseUrl}exercise/completed/'),
              body: {'category_id': categoryId, 'exercise_id': exerciseId},
              headers: {'Authorization': 'Bearer ${newAccess.right}'});
        }
      }
    } on Exception catch (e) {
      return Left(ErrorModel(e.toString()));
    }

    return Left(ErrorModel('SomeThing wrong'));
  }
}
