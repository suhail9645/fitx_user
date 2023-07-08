import 'package:either_dart/either.dart';
import 'package:fitx_user/data_layer/data_provider/user_report/user_report_add.dart';
import 'package:fitx_user/data_layer/models/error/error_model.dart';
import 'package:fitx_user/data_layer/models/user_report/user_report.dart';
import 'package:fitx_user/presentation/constants/strings.dart';

class UserGoalsAddrepo {
  Future<Either<ErrorModel, UserReport>> updateUserGoal(int? categoryGoal,
      int? exerciseGoal, int? calorieGoal, UserReport userReport) async {
    try {
      if (categoryGoal != null) {
        final response = await UserReportGoalsAddOperations()
            .addUserGoals(addCatgoryGoalEndPoint, categoryGoal);
        if (response.isRight) {
          userReport.categoryGoal = categoryGoal;
        }
      }
      if (exerciseGoal != null) {
        final response = await UserReportGoalsAddOperations()
            .addUserGoals(addExerciseGoalEndPoint, exerciseGoal);
        if (response.isRight) {
          userReport.exerciseGoal = exerciseGoal;
        }
      }
      if (calorieGoal != null) {
        final response = await UserReportGoalsAddOperations()
            .addUserGoals(addCalorieGoalEndPoint, calorieGoal);
        if (response.isRight) {
          userReport.calorieGoal = calorieGoal;
        }
      }
      return Right(userReport);
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }
}
