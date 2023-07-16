import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_report.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/exercise_page/result.dart';
import 'package:fitx_user/data_layer/models/user_report/user_report.dart';
import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:fitx_user/data_layer/models/user_transformation/user_transformation.dart';
import 'package:fitx_user/data_layer/models/user_weight/result.dart';
import 'package:fitx_user/data_layer/models/user_weight/user_weight.dart';
import 'package:fitx_user/data_layer/repositories/exercise_repo/exercise_repo.dart';
import 'package:fitx_user/presentation/constants/strings.dart';
import 'package:http/http.dart';
import '../exercise_repo/category_exercise_repo.dart';

class UserReportRepo {
  UserReport? userReport;
  int allCompletedCategory = 0;
  int allCompletedExercise = 0;
  int allCompletedCalorie = 0;
  int thisweekCompletedCategory = 0;
  int thisweekCompletedExercise = 0;
  int thisweekCompletedCalorie = 0;
  int exerciseGoal = 0;
  int categoryGoal = 0;
  int calorieGoal = 0;
  List<Weight> allWeights = [];
  List<TImage> allTImages = [];
  Future<void> getAllCategoryReport() async {
    Either<ErrorModel, Response> responseOrError = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(completedCategoryEndPoint);
    if (responseOrError.isRight) {
      Response response = responseOrError.right;
      List<int> allCompletedCategoryId = [];
      List<int> thisWeekCompletedCategoryId = [];
      List<Exercise> allCompletedExerciseList = [];
      allCompletedCategory = jsonDecode(response.body)['count'];
      List allCompletedCategories = jsonDecode(response.body)['results'];
      for (var element in allCompletedCategories) {
        DateTime completeDate = DateTime.parse(element['date']);
        DateTime todayDate = DateTime.now();
        DateTime sunday = todayDate.subtract(Duration(days: todayDate.weekday));
        if (completeDate.isAfter(sunday)) {
          thisWeekCompletedCategoryId.add(element['category']['id']);
        }
        allCompletedCategoryId.add(element['category']['id']);
      }
      thisweekCompletedCategory = thisWeekCompletedCategoryId.length;
      for (int element in allCompletedCategoryId) {
        final listOfExercise = await CategoryExerciseOperationsRepo()
            .getAllCategoryExercise(element);

        if (listOfExercise.isRight) {
          allCompletedExercise =
              allCompletedExercise + listOfExercise.right.length;
          allCompletedExerciseList.addAll(listOfExercise.right);
        }
        // print(element);
      }

      for (var element in allCompletedExerciseList) {
        allCompletedCalorie = allCompletedCalorie + element.burnCalorie!;
      }
      List<Exercise> thisWeekCompletedExerciseList = [];
      for (int element in thisWeekCompletedCategoryId) {
        final listOfExercise = await CategoryExerciseOperationsRepo()
            .getAllCategoryExercise(element);

        if (listOfExercise.isRight) {
          thisweekCompletedExercise =
              thisweekCompletedExercise + listOfExercise.right.length;
          thisWeekCompletedExerciseList.addAll(listOfExercise.right);
        }
        // print(element);
      }
      for (var element in thisWeekCompletedExerciseList) {
        thisweekCompletedCalorie =
            thisweekCompletedCalorie + element.burnCalorie!;
      }
    }
  }

  Future<void> getAllExerciseReport() async {
    Either<ErrorModel, Response> responseOrError = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(completedExerciseEndPoint);
    if (responseOrError.isRight) {
      List<int> allCompletedExerciseids = [];
      List<int> thisWeekCompletedExerciseIds = [];
      Response response = responseOrError.right;
      int exercise = jsonDecode(response.body)['count'];
      allCompletedExercise = allCompletedExercise + exercise;
      List allExerciseDetailes = jsonDecode(response.body)['results'];
      for (var element in allExerciseDetailes) {
        DateTime completeDate = DateTime.parse(element['date']);
        DateTime todayDate = DateTime.now();
        DateTime sunday = todayDate.subtract(Duration(days: todayDate.weekday));
        if (completeDate.isAfter(sunday)) {
          thisWeekCompletedExerciseIds.add(element['exercise_id']);
        }
        allCompletedExerciseids.add(element['exercise_id']);
      }
      thisweekCompletedExercise =
          thisweekCompletedExercise + thisWeekCompletedExerciseIds.length;
      for (var element in allCompletedExerciseids) {
        final exercise = await ExerciseOperationRepo().getExercise(element);
        if (exercise.isRight) {
          allCompletedCalorie =
              allCompletedCalorie + exercise.right.burnCalorie!;
        }
      }
      for (var element in thisWeekCompletedExerciseIds) {
        final exercise = await ExerciseOperationRepo().getExercise(element);
        if (exercise.isRight) {
          thisweekCompletedCalorie =
              thisweekCompletedCalorie + exercise.right.burnCalorie!;
        }
      }
    }
  }

  Future<void> getUserAllGoals() async {
    List<String> goalEndPoints = [
      addCatgoryGoalEndPoint,
      addExerciseGoalEndPoint,
      addCalorieGoalEndPoint
    ];

    int i = 0;
    while (i < goalEndPoints.length) {
      final response = await UserReportOperations()
          .getAllCompletedCategoryAndExercise(goalEndPoints[i]);
      if (response.isRight) {
        if (i == 0) {
          categoryGoal = jsonDecode(response.right.body)['goal'] ?? 0;
        } else if (i == 1) {
          exerciseGoal = jsonDecode(response.right.body)['goal'] ?? 0;
        } else if (i == 2) {
          calorieGoal = jsonDecode(response.right.body)['goal'] ?? 0;
        }
      }
      i++;
    }
  }

  Future<void> getUserAllWeights() async {
    final eitherResponse = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(userWeightEndPoint);
    if (eitherResponse.isRight) {
      Response response = eitherResponse.right;
      Map<String, dynamic> data = jsonDecode(response.body);
      UserWeight userWeight = UserWeight.fromJson(data);
      for (var element in userWeight.results ?? []) {
        Weight weight = Weight.fromJson(element);
        allWeights.add(weight);
      }
    }
  }

  Future<void> getAllTransformationImages() async {
    final eitherResponse = await UserReportOperations()
        .getAllCompletedCategoryAndExercise(transformationImageEndPoint);
    if (eitherResponse.isRight) {
      Response response = eitherResponse.right;
      Map<String, dynamic> data = jsonDecode(response.body);
      UserTransformation transformation = UserTransformation.fromJson(data);
      for (var element in transformation.results ?? []) {
        TImage tImage = TImage.fromJson(element);
        allTImages.add(tImage);
      }
    }
  }

  Future<UserReport> getAllUserDetailes() async {
    await getAllCategoryReport();
    await getAllExerciseReport();
    await getUserAllGoals();
    await getUserAllWeights();
    await getAllTransformationImages();
    return UserReport(
        allCompletedCategory,
        allCompletedExercise,
        allCompletedCalorie,
        thisweekCompletedCategory,
        thisweekCompletedExercise,
        thisweekCompletedCalorie,
        allWeights,
        calorieGoal,
        categoryGoal,
        exerciseGoal,
        allTImages);
  }
}
