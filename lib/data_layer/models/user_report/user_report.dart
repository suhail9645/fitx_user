import 'package:fitx_user/data_layer/models/user_transformation/result.dart';
import 'package:fitx_user/data_layer/models/user_weight/result.dart';

class UserReport {
  int allCompletedCategory;
  int allCompletedExercise;
  int allCompletedCalorie;
  int thisweekCompletedCategory;
  int thisweekCompletedExercise;
  int thisweekCompletedCalorie;
  List<Weight> allWeights;
  int exerciseGoal;
  int categoryGoal;
  int calorieGoal;
  List<TImage> tImages;
  UserReport(
      this.allCompletedCategory,
      this.allCompletedExercise,
      this.allCompletedCalorie,
      this.thisweekCompletedCategory,
      this.thisweekCompletedExercise,
      this.thisweekCompletedCalorie,
      this.allWeights,
      this.calorieGoal,
      this.categoryGoal,
      this.exerciseGoal,
      this.tImages);
}
