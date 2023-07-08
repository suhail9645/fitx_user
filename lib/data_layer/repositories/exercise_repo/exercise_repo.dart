import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/exercise/exercise_imp.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:http/http.dart';

class ExerciseOperationRepo {
  Future<Either<ErrorModel, Exercise>> getExercise(int id) async {
    final responseOrError = await ExerciseOperationsImp().getExerciseWithId(id);
    if (responseOrError.isLeft) {
      return Left(ErrorModel(responseOrError.left.error));
    } else {
      Response response = responseOrError.right;
      Exercise exercise = Exercise.fromJson(jsonDecode(response.body));
      return Right(exercise);
    }
  }
}
