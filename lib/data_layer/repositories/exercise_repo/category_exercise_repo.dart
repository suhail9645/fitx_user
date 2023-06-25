import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/exercise/category_exercise_imp.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/exercise_page/exercise_page.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:http/http.dart';

class CategoryExerciseOperationsRepo {
  Future<Either<ErrorModel, List<Exercise>>> getAllCategoryExercise(
      int id) async {
    final response = await CategoryExerciseOperations().getCategoryExercise(id);
    if (response.isLeft) {
      return Left(ErrorModel(response.left.error));
    } else {
      Response exerciseResponse = response.right;
      List<Exercise> exercises = [];

      while (true) {
        Map<String, dynamic> data = jsonDecode(exerciseResponse.body);
        ExercisePage exercisePage = ExercisePage.fromJson(data);

        for (var element in exercisePage.results ?? []) {
          Exercise exercise = Exercise.fromJson(element);
          exercises.add(exercise);
        }

        if (exercisePage.next != null) {
          final nextPageResponse = await CategoryExerciseOperations()
              .categoryExerciseNextPage(exercisePage.next);
          if (nextPageResponse.isRight) {
            exerciseResponse = nextPageResponse.right;
          }
        } else {
          break;
        }
      }
      return Right(exercises);
    }
  }
}
