class UserReport {
  final int allCompletedCategory;
  final int allCompletedExercise;
  final int allCompletedCalorie;
  final int thisweekCompletedCategory;
  final int thisweekCompletedExercise;
  final int thisweekCompletedCalorie;
  final List<double> allWeights;
  final double currentWeight;
  final double heaviestWeight;
  final double lightestWeight;
  final int exerciseGoal;
  final int categoryGoal;
  final int calorieGoal;
  UserReport(
      {required this.allCompletedCategory,
      required this.allCompletedExercise,
      required this.allCompletedCalorie,
      required this.thisweekCompletedCategory,
      required this.thisweekCompletedExercise,
      required this.thisweekCompletedCalorie,
      required this.allWeights,
      required this.currentWeight,
      required this.heaviestWeight,
      required this.lightestWeight,
      required this.calorieGoal,
      required this.categoryGoal,
      required this.exerciseGoal});
}
