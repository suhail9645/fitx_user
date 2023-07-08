import 'package:fitx_user/data_layer/models/user_weight/result.dart';

class UserReport {
  int allCompletedCategory;
  int allCompletedExercise;
  int allCompletedCalorie;
  int thisweekCompletedCategory;
  int thisweekCompletedExercise;
  int thisweekCompletedCalorie;
  List<Weight> allWeights;
  double currentWeight;
  double heaviestWeight;
  double lightestWeight;
  int exerciseGoal;
  int categoryGoal;
  int calorieGoal;
  UserReport(
      this.allCompletedCategory,
      this.allCompletedExercise,
      this.allCompletedCalorie,
      this.thisweekCompletedCategory,
      this.thisweekCompletedExercise,
      this.thisweekCompletedCalorie,
      this.allWeights,
      this.currentWeight,
      this.heaviestWeight,
      this.lightestWeight,
      this.calorieGoal,
      this.categoryGoal,
      this.exerciseGoal);
}
