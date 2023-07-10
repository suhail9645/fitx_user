part of 'report_bloc.dart';

abstract class ReportEvent {}

class ReportInitialEvent extends ReportEvent {}

class UpadateGoalEvent extends ReportEvent {
  final int? categoryGoal;
  final int? exerciseGoal;
  final int? calorieGoal;
  final UserReport userReport;
  UpadateGoalEvent(
      this.categoryGoal, this.exerciseGoal, this.calorieGoal, this.userReport);
}

class UpdateWeightEvent extends ReportEvent {
  final double weight;
  final UserReport userReport;

  UpdateWeightEvent({required this.weight, required this.userReport});
}

class AddTransformationImage extends ReportEvent{
  final UserReport userReport;

  AddTransformationImage({required this.userReport});
}
